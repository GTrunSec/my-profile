## Weather forecast for Polybar
![preview](https://github.com/kamek-pf/polybar-forecast/blob/master/screenshots/preview.png)

This is a simple weather forecast module for Polybar. \
The first number is the current temperature and the second one is a 3 hour forecast.

You need Weather Icons and Material Icons for this to work properly. \
Both are available in the AUR:
- [Weather Icons](https://aur.archlinux.org/packages/ttf-weather-icons/)
- [Material Icons](https://aur.archlinux.org/packages/ttf-material-icons/)

### Configuration
Look at the example TOML configuration file.

```toml
# Register at https://openweathermap.org to get your API key
api_key = "YOUR_API_KEY"

# This is for Montreal, find your city at https://openweathermap.org
# The id will be the last part of the URL
city_id = "6077243"

# Display settings
units = "metric"
display_symbol = "°C"
```

### Build
Run `cargo build --release`, the you'll find the binary `target/release/polybar-forecast`.
You can copy the binary anywhere you want, but `config.toml` has to be in the same directory.

### Polybar integration
You can define your new module like this :

```
[module/weather]
type = custom/script
exec = ~/.config/polybar/modules/forecast/polybar-forecast
exec-if = ping openweathermap.org -c 1
interval = 600
label-font = 3
```
Don't forget to add Weather Icons to your config or it won't render correctly :
```
...
font-2 = Weather Icons:size=12;0
...
```

Then you may add your new `weather` module on your bar.
