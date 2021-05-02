classdef Solar < handle
    %SOLAR Apparent daily path of the sun
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
            %SOLAR Construct an instance of this class
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
            % Bu metod AST değerinin ondalıklı değeri ile çalışmalı
            obj.HourAngle = (obj.Ast - 12) * 15;
        end
        
        function [] = calculateDeclination(obj)
            % δ = 23.45 * sin(360/365 * (284 + N))
            % N -> Yılın günü
            obj.Declination = 23.45 * sind(360/365 * (284 + obj.DayOfTheYear));
        end
       
        function [] = calculateAltitude(obj)
            a  = sind(obj.Latitude) * sind(obj.Declination) + cosd(obj.Latitude) * cosd(obj.Declination) * cosd(obj.HourAngle);
            obj.Altitude = asind(a);
        end
        
        function [] = calculateAzimuth(obj)
            z =  cosd(obj.Declination) * sind(obj.HourAngle) / cosd(obj.Altitude);
            obj.Azimuth = asind(z);
        end
    end
end
