classdef Location
    % Şehre ait enlem, boylam, saat ve tarih ile ilgili verileri tutacak sınıf
    
    properties
        CityName; % Şehir ismi
        Date;     % Güneş konumunun hesaplanacağı tarih
        Time;     % Güneş konumunun hesaplanacağı saat
        TimeZone; % Şehrin bulundğu zaman dilimi
        LocalLongitude; % Şehrin boylamı
        LocalLatitude;  % Şehrin enlemi
    end
    
    methods
        function obj = Location(cityName, date, time, timeZone, localLongitude, localLatitude)
            % Kullanıcının gireceği lokasyon bilgilerinin yapıcı fonksiyon yardımıyla gerekli değişkenlere ataması yapılıyor.
            obj.CityName = cityName;
            obj.Date = date;
            obj.Time = time;
            obj.TimeZone = obj.CheckTimeZone(timeZone);
            obj.LocalLongitude = localLongitude;
            obj.LocalLatitude = localLatitude;
        end
        
        function response = CheckTimeZone(obj, timeZone)
            % Saat dilimi (time zone) değeri maksimum +13 minimum -11 olabilir.
            % Kullanıcının girdiği değer bu fonksiyon yardımıyla kontrol ediliyor ve belirtilen bu aralıktan
            % az ve ya fazla olduğu durum ortaya çıkıyor ise gönderdiği değer yerine 0 (sıfır) değeri atanıyor.
            % Bu nedenle yapılacak işlemler de bu 0 (sıfır) değerini baz alarak yapılmış olacak.
            if timeZone < -12 || timeZone > 14
                response =  0;
                return;
            end
            response =  timeZone;
        end

    end
end

