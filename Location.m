classdef Location
    %   Şehire ait enlem, boylam, saat ve tarih ile ilgili verileri tutacak
    %   sınıf
    
    properties
        CityName; %Şehir ismini
        Date;     %Güneş konumunun hesaplanacağı tarih
        Time;     %Güneş konumunun hesaplanacağı saat
        TimeZone; %Şehrin bulundğu zaman dilimi
        LocalLongitude; %Şehrin boylamı
        LocalLatitude;  %Şehrin enlemi
    end
    
    methods
        function obj = Location(cityName, date, time, timeZone, localLongitude, localLatitude)
            %Kullanıcının gireceği lokasyon bilgilerinin yapıcı metod yardımıyla gerekli değişkenlere ataması yapılıyor.
            obj.CityName = cityName;
            obj.Date = date;
            obj.Time = time;
            obj.TimeZone = obj.CheckTimeZone(timeZone);
            obj.LocalLongitude = localLongitude;
            obj.LocalLatitude = localLatitude;
        end
        
        function response = CheckTimeZone(obj, timeZone)
            %Kullanıcının girdiği zaman diliminin değeri geçerli bir değer olup olmadığı kontrol ediliyor.
            if timeZone < -12 || timeZone > 14
                response =  0;
                return;
            end
            response =  timeZone;
        end

    end
end

