classdef Location
    %LOCATION Summary of this class goes here
    %   Þehire ait enlem, boylam, saat ve tarih ile ilgili verileri tutacak
    %   sýnýf
    
    properties
        CityName;
        Date;
        Time;
        TimeZone;
        LocalLongitude;
        LocalLatitude;
    end
    
    methods
        function obj = Location(cityName, date, time, timeZone, localLongitude, localLatitude)
            obj.CityName = cityName;
            obj.Date = date;
            obj.Time = time;
            obj.TimeZone = obj.CheckTimeZone(timeZone);
            obj.LocalLongitude = localLongitude;
            obj.LocalLatitude = localLatitude;
        end
        
        function response = CheckTimeZone(obj, timeZone)
            if timeZone < -12 || timeZone > 14
                response =  0;
                return;
            end
            response =  timeZone;
        end

    end
end

