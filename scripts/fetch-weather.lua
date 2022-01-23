#!/usr/bin/lua

-- Original script source: https://gist.github.com/meskarune/5729e8d6c8428e9c70a72bed475db4e1

json = require("json")

api_url = "http://api.openweathermap.org/data/2.5/weather?"

-- ENTER YOUR CITY ID BETWEEN THE QUATATION MARKS
-- http://openweathermap.org/help/city_list.txt , http://openweathermap.org/find
city_id = ""

-- metric or imperial
cf = "metric"

-- fetch conky greet
-- greet = "${execi 60 ~/.conky/ssui-forked/scripts/greeting.sh}"

-- ENTER YOUR API KEY BETWEEN THE QUATATION MARKS
-- get an open weather map api key: http://openweathermap.org/appid
api_key = ""

-- measure is °C if metric and °F if imperial
measure = '°' .. (cf == 'metric' and 'C' or 'F')

-- Default icons (day)
icons = {
    ["01"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}", --sun
    ["02"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}", --sun & clouds
    ["03"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["04"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["09"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["10"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["11"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["13"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
    ["50"] = "${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}",
  }

time = os.date("*t") -- time.hour

if(time.hour < 6) -- Night icons
then
    icons["01"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["02"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["10"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"

elseif(time.hour < 18) -- Day Icons
then
    icons["01"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["02"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["10"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"

else -- Night icons
    icons["01"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["02"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
    icons["10"]="${font EmbraceConkyIcons:size=14}${color1}${font Product Sans Light:size=18}${color1}${voffset -7}${offset 1}"
end

cache_file = "weather.json"

currenttime = os.date("!%Y%m%d%H%M%S")

file_exists = function (name)
    f=io.open(name,"r")
    if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

if file_exists(cache_file) then
    cache = io.open(cache_file,"r+")
    data = json.decode(cache:read())
    timepassed = os.difftime(currenttime, data.timestamp)
else
    cache = io.open(cache_file, "w")
    timepassed = 6000
end

makecache = function (s)
    s.timestamp = currenttime
    save = json.encode(s)
    cache:write(save)
end

capture = function(cmd, raw)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))
    
    handle:close()
    
    if raw then 
        return output 
    end
   
    output = string.gsub(
        string.gsub(
            string.gsub(output, '^%s+', ''), 
            '%s+$', 
            ''
        ), 
        '[\n\r]+',
        ' '
    )
   
   return output
end

if timepassed < 3600 then
    response = data
else
    weather = capture(string.format("curl -L \'%sid=%s&units=%s&APPID=%s\'", api_url, city_id, cf, api_key))
    if weather then
        response = json.decode(weather)
        makecache(response)
    else
        response = data
    end
end

math.round = function (n)
    return math.floor(n + 0.5)
end

temp = response.main.temp
conditions = response.weather[1].main
place = response.name
icon = response.weather[1].icon:sub(1, 2)

-- Original: io.write(("%s%s | %s\n"):format(math.round(temp), measure, conditions))
-- Minimal: io.write(("%s%s"):format(math.round(temp), measure))
io.write(("%s %s%s"):format(icons[icon], math.round(temp), measure))

cache:close()