classdef Solar < handle
    %   Solar Altitude ve Solar Azimuth değerlerini hesaplayan sınıf
    %   Solar Altitude -> sin(α) = sin(L)sin(δ)+cos(L)cos(δ)cos(h)
    %           α -> Solar Altitude
    %           L -> Local Latitude
    %           δ -> Declination
    %           h -> Hour Angle
    %   Solar Azimuth -> sin(z) = cos(δ)sin(h)/cos(α)
    %           z -> Solar Azimuth
    %           δ -> Declination
    %           h -> Hour Angle
    %           α -> Solar Altitude
    
    properties
        Latitude;
        HourAngle;
        Declination;
        Azimuth;
        Altitude;
        Ast;
        DayOfTheYear;
    end
    
    methods
        function obj = Solar(ast, latitude)
            %   Bu sınıf AST nesnesi ve latitude değeri ile çalışabilir.
            obj.Latitude = latitude;
            obj.DayOfTheYear = ast.DayOfTheYear;
            obj.Ast = ast.AstFloat;
            
            obj.calculateHourAngle();
            obj.calculateDeclination();
            obj.calculateAltitude();
            obj.calculateAzimuth();
        end
        
        function [] = calculateHourAngle(obj)
            % (AST - 12) * 15
            % Bu metod AST değerinin ondalıklı değeri ile çalışmalı
            % Hesaplanan değer ilgili property'ye atanır.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            obj.HourAngle = (obj.Ast - 12) * 15;
        end
        
        function [] = calculateDeclination(obj)
            % δ = 23.45 * sin(360/365 * (284 + N))
            % N -> Yılın günü
            % Yılın herhangi bir günü için derece cinsinden sapmayı hesaplar ve ilgili property'ye atar.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            obj.Declination = 23.45 * sind(360 / 365 * (284 + obj.DayOfTheYear));
        end
       
        function [] = calculateAltitude(obj)
            % Güneş ışınları ile yatay düzlem arasındaki açıdır.
            % Hesaplanan bu değer ilgili property'ye atanır.
            % Hesaplamalar derece olarak sonuç verdiğinden sind, cosd veya asind gibi d ile biten fonksiyonlar
            % gerekli hesaplamayı yaparken gönderilen değerlerin derece olduğunu kabul edip işlemler yapar.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            % Neden arcsinus ? Hesaplanan değerin formülde a'ya değil de sin(a)'ya eşit olduğu söylendiğinden 
            % bu sin(a)'nın kaç derece olduğunu bulabilmek için arcsin kullanıldı.
            a  = sind(obj.Latitude) * sind(obj.Declination) + cosd(obj.Latitude) * cosd(obj.Declination) * cosd(obj.HourAngle);
            obj.Altitude = asind(a);
        end
        
        function [] = calculateAzimuth(obj)
            % Kuzey Yarımküre için güneyden veya Güney Yarımküre için kuzeyden itibaren yatay düzlemde ölçülen güneş 
            % ışınlarının açısıdır.
            % Hesaplanan bu değer ilgili property'ye atanır.
            % Neden arcsinus ? Hesaplanan değerin formülde a'ya değil de sin(a)'ya eşit olduğu söylendiğinden 
            % bu sin(a)'nın kaç derece olduğunu bulabilmek için arcsin kullanıldı.
            % Boş bir dizi geri döndürür. Bizim için void anlamına geldiğini varsayabiliriz.
            z =  cosd(obj.Declination) * sind(obj.HourAngle) / cosd(obj.Altitude);
            obj.Azimuth = asind(z);
        end
    end
end
