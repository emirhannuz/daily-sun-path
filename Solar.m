classdef Solar < handle
    %SOLAR Apparent daily path of the sun
    %   Solar Altitude ve Azimuth deðerlerini hesaplayan sýnýf
    
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
            %   AST sýnýfýndan türetilmiþ bir nesne 
            obj.Latitude = latitude;
            obj.DayOfTheYear = ast.DayOfTheYear;
            obj.Ast = ast.AstFloat;
            
            obj.calculateHourAngle();
            obj.calculateDeclination();
            obj.calculateAltitude();
            obj.calculateAzimuth();
        end
        
        function [] = calculateHourAngle(obj)
            obj.HourAngle = (obj.Ast-12)*15;
        end
        
        function [] = calculateDeclination(obj)
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