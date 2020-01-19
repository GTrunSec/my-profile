use std::cmp::Ordering;
use std::{env, process};

use handlebars::TemplateRenderError;
use serde::{Deserialize, Serialize};
use thiserror::Error;

const CFG_PATH: &str = "$HOME/.config/polybar-forecast/config.toml";

#[derive(Debug, Deserialize, Clone)]
pub struct Configuration {
    #[serde(default = "api_key_from_env")]
    pub api_key: String,
    pub city_id: String,
    pub display: String,
}

#[derive(Debug, Serialize)]
pub struct Output {
    pub temp_celcius: i16,
    pub temp_kelvin: i16,
    pub temp_fahrenheit: i16,
    pub temp_icon: char,
    pub trend: char,
    pub forecast_celcius: i16,
    pub forecast_kelvin: i16,
    pub forecast_fahrenheit: i16,
    pub forecast_icon: char,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Unit {
    Kelvin,
    Celcius,
    Fahrenheit,
}

#[derive(Debug, Clone, Copy, Eq)]
pub struct Temperature(pub i16, pub Unit);

// If the api_key field is missing in the config file, we try to read it from env variables
fn api_key_from_env() -> String {
    match env::var("OWM_API_KEY") {
        Ok(key) => key,
        Err(_) => {
            eprintln!("\nCould not find OpenWeatherMap API key. Make sure api_key is set in the config file, or the OWM_API_KEY env variable is defined");
            process::exit(1);
        }
    }
}

impl PartialEq for Temperature {
    fn eq(&self, other: &Temperature) -> bool {
        let other = other.as_unit(self.1);
        self.0 == other.0
    }
}

impl PartialOrd for Temperature {
    fn partial_cmp(&self, other: &Temperature) -> Option<Ordering> {
        Some(self.cmp(&other))
    }
}

impl Ord for Temperature {
    fn cmp(&self, other: &Temperature) -> Ordering {
        let other = other.as_unit(self.1);
        self.0.cmp(&other.0)
    }
}

impl Temperature {
    pub fn as_unit(self, unit: Unit) -> Temperature {
        use Unit::*;
        match (self.0, self.1, unit) {
            // Kelvin to Celcius
            (val, Kelvin, Celcius) => Temperature(val - 273.15 as i16, Celcius),
            // Kelvin to Fahrenheit
            (val, Kelvin, Fahrenheit) => Temperature(val * 9 / 5 - 459.67 as i16, Fahrenheit),
            // Celcius to Kelvin
            (val, Celcius, Kelvin) => Temperature(val + 273.15 as i16, Kelvin),
            // Celcius to Fahrenheit
            (val, Celcius, Fahrenheit) => Temperature(val * 9 / 5 + 32 as i16, Fahrenheit),
            // Fahrenheit to Kelvin
            (val, Fahrenheit, Kelvin) => Temperature((val + 459.67 as i16) * 5 / 9 as i16, Kelvin),
            // Fahrenheit to Celcius
            (val, Fahrenheit, Celcius) => Temperature((val - 32) * 5 / 9 as i16, Celcius),
            // Identity
            _ => self,
        }
    }
}

impl Unit {
    pub fn to_api(&self) -> &str {
        match self {
            Unit::Celcius => "metric",
            Unit::Fahrenheit => "imperial",
            Unit::Kelvin => "kelvin",
        }
    }
}

#[derive(Debug, Error)]
pub enum Error {
    #[error("Failed to query OpenWeatherMap: {}", _0)]
    HttpError(#[from] reqwest::Error),

    #[error("Config file error, please check {}: {}", CFG_PATH, _0)]
    InvalidConfigFile(#[from] toml::de::Error),

    #[error("Failed to render output, {}", _0)]
    InvalidTemplate(#[from] TemplateRenderError),

    #[error("Could not open config file, please check {}", CFG_PATH)]
    MissingConfigFile,

    #[error("Invalid response from OpenWeatherMap")]
    InvalidResponse,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn unit_converter() {
        use Unit::*;

        assert_eq!(
            Temperature(0, Celcius).as_unit(Fahrenheit),
            Temperature(32, Fahrenheit)
        );

        assert_eq!(
            Temperature(-50, Celcius).as_unit(Kelvin),
            Temperature(223.15 as i16, Kelvin)
        );

        assert_eq!(
            Temperature(32, Fahrenheit).as_unit(Celcius),
            Temperature(0, Celcius)
        );

        assert_eq!(
            Temperature(-459.67 as i16, Fahrenheit).as_unit(Kelvin),
            Temperature(0, Kelvin)
        );

        assert_eq!(
            Temperature(223.15 as i16, Kelvin).as_unit(Celcius),
            Temperature(-50, Celcius)
        );

        assert_eq!(
            Temperature(0, Kelvin).as_unit(Fahrenheit),
            Temperature(-459.67 as i16, Fahrenheit)
        );
    }

    #[test]
    fn unit_cmp() {
        use Unit::*;
        assert!(Temperature(0, Celcius) <= Temperature(0, Celcius));
        assert!(!(Temperature(0, Celcius) < Temperature(0, Celcius)));

        assert!(Temperature(1, Celcius) > Temperature(30, Fahrenheit));
        assert!(Temperature(100, Kelvin) < Temperature(25, Celcius));
    }
}
