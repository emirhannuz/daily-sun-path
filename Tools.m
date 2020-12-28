classdef Tools
    %TOOLS Yardýmcý Fonksiyonlarý barýndýran sýnýf
    
    properties
        
    end
    
    methods
        function dayOfTheYear = DayOfTheYearFromGivenDate(obj, date)
            splitedDate = split(date, "/");
            dayInt = str2num(splitedDate(1));
            monthInt = str2num(splitedDate(2));
            yearInt = str2num(splitedDate(3));
            date = datetime(yearInt, monthInt, dayInt);
            dayOfTheYear = day(date, 'dayofyear');
        end   
        
        function time = String2Time(obj, strTime)
            dtv = datevec(datetime(strTime,'InputFormat','HH:mm'));
            time = duration(dtv(:,4:end));
        end
        
        function time = Number2Minute(obj, numberTime)
            time = duration(minutes(numberTime), 'format', 'hh:mm');
        end
        
        function floatValue = Time2Float(obj, time)
            dtv = datevec(time);
            neededPart = dtv(4:5);
            if neededPart(2) < 0
                joinedWithDot = '-' + join(string(abs(neededPart)), '.');
            else
                joinedWithDot = join(string(neededPart), '.');
            end
            floatValue = str2double(joinedWithDot);
        end
        
        function float = TimeMapping(obj, time)
            value = obj.Time2Float(time);
            integerValue = floor(value);
            floatPart = value - integerValue;
            roundedValue = round(floatPart*100);
            mappingValue = round(obj.MapIt(roundedValue, 0, 59, 0, 99));
            float = integerValue + (mappingValue / 100);
        end
        
        function value = MapIt(obj, val, inMin, inMax, outMin, outMax)
            value = (val - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
        end
        
    end
end