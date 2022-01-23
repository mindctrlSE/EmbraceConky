## Embrace - Conky Config

Conky widget with inspired colors from Dracula Theme.
This config currently includes:

- Greeting message: The user is greeted depending on time of the day
- Time, Date & Weather: Displays time, date and weather update using OpenWeather API
- Now playing (Spotify): Displays artist and title of current track playing on spotify.

![](https://github.com/mindctrlSE/EmbraceConky/blob/main/Screenshot.png)

## Dependencies

- Conky
- API key from [Open Weather Map](https://openweathermap.org/api)
- spotify-cli-linux [(pip)](https://pypi.org/project/spotify-cli-linux/) (optional)

### Fonts

- [Product Sans](https://search.brave.com/search?q=product+sans)
- EmbraceConkyIcons (inlcuded in repo)

## Installation

1.  Extract the files to your `~/.conky` folder.
2.  After installing the fonts, rebuild the font cache from terminal by `fc-cache -f -v`.
3.  Enter your OpenWeather API key and City ID in `~/.conky/scripts/fetch-weather.lua`

## Usage

Run `~/.conky/EmbraceTheme/conkystart.sh` to start the scripts. Add this file to your autostartup to run at login.

## Widget details

The widgets was created for 16:10 display with a resolution of 1920x1200px. You might need to adjust `gap_y`, `voffset` and `offset` parameters in the corresponding config file to match your resolution. Moreover, adjust `font-size` to match your resultion and liking. Below you will find details for each widget

### greeting

The greeting is set the change ever 6 hours:

- 00h-06h: Good Night
- 06h-12h: Good Morning
- 12h-18h: Good Afternoon
- 18h-24h: Good Evening

This can be changed at `~/.conky/EmbraceConky/scripts/conkyGreet.sh`.

### clock_weather 

Please notice that you need to enter your [Open Weather API-key](https://openweathermap.org/api) and [City ID](https://openweathermap.org/find) to get the weather widget to work. You may also change the date formating to your liking. 

### Spotify

Spotify-cli is used by default. You can also `exec` the `/scripts/title.sh` and `/scripts/artist.sh` that basically does the same thing over dbus. However, I was unreliable on my system. 

## Todo

- Make the weather icons change dependent on sun raise/sun set instead of time of the day.
- An exteded widget with system information is in the works

## Credit

This is a heavly inspired from [SSUI conky](https://github.com/sstojkovic/ssui-conky). Thanks to [micahco](https://github.com/micahco) for developing [Spotify-now](https://github.com/micahco/spotify-now) and [codeit13](https://gist.github.com/codeit13) for [inspiring](https://gist.github.com/codeit13/7284e03cd01d2c13e91f88052ed6cee7#file-greet-sh) the greeing bash script.
