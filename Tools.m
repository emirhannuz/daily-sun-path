classdef Tools
    %TOOLS Yardımcı Fonksiyonları barındıran sınıf
    % https://www.mathworks.com/help/matlab/date-and-time-operations.html
    properties
        
    end
    
    methods
        function dayOfTheYear = DayOfTheYearFromGivenDate(obj, date)
            % DD/MM/YYYY formatında olduğu kabul edilen string bir değerin yılın kaçıncı gününe 
            % denk geldiğini hesaplayan fonksiyon
            splitedDate = split(date, "/"); % split fonksiyonu gönderilen stringi 
            % belirtilen ayraç baz alınarak parçalara böler ve geriye bir dizi döndürür.
            dayInt = str2num(splitedDate(1));
            monthInt = str2num(splitedDate(2));
            yearInt = str2num(splitedDate(3));
            date = datetime(yearInt, monthInt, dayInt);
            dayOfTheYear = day(date, 'dayofyear');
        end   
        
        function time = String2Time(obj, strTime)
            % strTime -> HH:mm formatında bir string değer olmalı.
            % String bir değeri belirtilen formatta Zamana çevirir.
            % Belirttiğimiz format (:) nokta ile ayrılmış olduğunu ve
            % sadece saat ve dakika kısmınının belirtildiğini söylüyor..
            % Matlab içerisinde hazır gelen fonksiyonlar ilede string değerimizi 
            % zamana çevirmiş oluyoruz.
            dtv = datevec(datetime(strTime,'InputFormat','HH:mm'));
            time = duration(dtv(:,4:end));
        end
        
        function time = Number2Minute(obj, numberTime)
            % Sayıyı zamana çevirir.
            time = duration(minutes(numberTime), 'format', 'hh:mm');
        end
        
        function floatValue = Time2Float(obj, time)
            % Zamanını ondalıklı sayıya çevirir.
            dtv = datevec(time);
            neededPart = dtv(4:5);
            if neededPart(2) < 0
                % değer sıfırdan küçükse ondalıklı sayı yapmadan önce önüne eksi işareti ekliyoruz.
                % Bu kısım olmadığı takdirde fonksiyon her zaman pozitif bir sonuç verir. 
                % Bu da istediğimiz bir şey değildir.
                joinedWithDot = '-' + join(string(abs(neededPart)), '.');
            else
                joinedWithDot = join(string(neededPart), '.');
            end
            floatValue = str2double(joinedWithDot);
        end
        
        function float = TimeMapping(obj, time)
            % Zaman tipindeki değerin 0,99 aralığındaki karşılığını hesaplar.
            value = obj.Time2Float(time);
            integerValue = floor(value);
            floatPart = value - integerValue;
            roundedValue = round(floatPart*100);
            mappingValue = round(obj.MapIt(roundedValue, 0, 59, 0, 99));
            float = integerValue + (mappingValue / 100);
        end
        
        function value = MapIt(obj, val, inMin, inMax, outMin, outMax)
            % belirtilen aralıkta verilmiş bir değerin belirtilen başka bir aralıkta ki değerini hesaplar.
            % (bkz. arduino map fonksiyonu)
            value = (val - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
        end
        
    end
end
