classdef AST < handle
    %AST Apparent Solar Time
    %    Görünen Güneş Zamanı'nı hesaplayan sınıf.
    %    Bu sınıfta hesaplanan değer, Saat Açısı'nı (Hour Angle) hesaplamak
    %    için gerekli.
    
    %    Formül       -> AST = LST + ET (+-) 4(SL-LL) - DS
    %    LST          -> Local Standart Time
    %    ET           -> Equation Of Time
    %    SL           -> Standart Longitude
    %    LL           -> Local Longitude
    %    DS           -> Daylight Saving
    %    (+-)4(SL-LL) -> Longitude Correction
    
    properties
        Tool = Tools();
        AstFloat; % İşlemler sonucu hesaplanan AST değerinin -ondalıklı- olarak tutulacağı property
        AstTime;  % İşlemler sonucu hesaplanan AST değerinin -zaman- olarak tutulacağı property
        EquationOfTime; 
        LocalStandardTime; 
        StandardLongitude; 
        LocalLongitude; 
        LongitudeCorrection;
        Date;
        DayOfTheYear; %EquationTime değeri hesaplanırken ihtiyaç duyulan B değerini hesaplarken ihtiyacımız olacak.
        DaylightSaving = false; %yaz saati uygulaması. Hesaplamalar bu değer göz önüne alınmadan yapıldı
    end
    
    methods
        function obj = AST(location)
            % Bu sınıfın çalışabilmesi için location nesnesine ihtiyaç vardır.
            obj.Date = location.Date;
            obj.LocalStandardTime = obj.Tool.String2Time(location.Time);
            obj.StandardLongitude = location.TimeZone * 15; % şehre ait standart boylam bulunduğu saat dilimi * 15'e eşittir.
            obj.LocalLongitude = location.LocalLongitude;
            obj.SetDayOfTheYear();
            obj.CalculateLongitudeCorrection();
            obj.CalculateEquationOfTime();
            obj.AstTime = obj.calculateAST();
            obj.AstFloat = obj.Tool.TimeMapping(obj.AstTime);
        end
        
        function ast = calculateAST(obj)
            % AST = LST + LC + ET
            ast = obj.LocalStandardTime + obj.Tool.Number2Minute(round(obj.EquationOfTime)) + obj.Tool.Number2Minute(round(obj.LongitudeCorrection));
        end
        
        function [] = CalculateLongitudeCorrection(obj)
            % (+-)4 * (SL - LL)
            % Boylam düzeltme (LC) değerini hesaplar ve gerekli property'ye atar.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
             obj.LongitudeCorrection = -4 * (obj.StandardLongitude - obj.LocalLongitude);
        end
        
        function [] = CalculateEquationOfTime(obj)
            % ET = 9.87 sin(2B) - 7.53 cos(B) - 1.5 sin(B) [min]
            % Zaman denklemini hesaplar ve sınıf içerisindeki gerekli property'ye atar.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            B = obj.CalculateB();
            obj.EquationOfTime = 9.87*sind(2*B) - 7.53*cosd(B) - 1.5*sind(B);
        end
        
        function b = CalculateB(obj)
            % B = (N - 81) * 360/364 
            % N -> Belirtilen tarihin yılın kaçıncı günü olduğudur.
            % Hesaplanan değeri geri döndürür.
            b = (obj.DayOfTheYear - 81) * (360 / 364);
        end
        
        function [] = SetDayOfTheYear(obj)
            % Tarihin yılın kaçıncı günü olduğunu yardımcı fonksiyon yardımıyla hesaplar ve sınıf içerisindeki 
            % property'ye atar.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            obj.DayOfTheYear = obj.Tool.DayOfTheYearFromGivenDate(obj.Date);
        end

    end
end
