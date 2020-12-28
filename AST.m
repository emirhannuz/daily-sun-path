classdef AST < handle
    %AST Apparent Solar Time
    %    Görünen Güneþ Zamanýný hesaplayan sýnýf.
    %    Bu sýnýfta hesaplanan deðer, Saat Açýsýsý'ný (Hour Angle) hesaplamak
    %    için gerekli.
    
    properties
        Tool = Tools();
        AstFloat; %Float value of ast
        AstTime;  %Time value of ast
        EquationOfTime;
        LocalStandardTime;
        StandardLongitude;
        LocalLongitude;
        LongitudeCorrection;
        Date;
        DayOfTheYear;
        DaylightSaving = false;
    end
    
    methods
        function obj = AST(location)
            %AST Construct an instance of this class
            %   Detailed explanation goes here
            obj.Date = location.Date;
            obj.LocalStandardTime = obj.Tool.String2Time(location.Time);
            obj.StandardLongitude = location.TimeZone * 15;
            obj.LocalLongitude = location.LocalLongitude;
            obj.SetDayOfTheYear();
            obj.CalculateLongitudeCorrection();
            obj.CalculateEquationOfTime();
            obj.AstTime = obj.calculateAST();
            obj.AstFloat = obj.Tool.TimeMapping(obj.AstTime);
        end
        
        function ast = calculateAST(obj)
            %ast = LST + LC + ET
            ast = obj.LocalStandardTime + obj.Tool.Number2Minute(round(obj.EquationOfTime)) + obj.Tool.Number2Minute(round(obj.LongitudeCorrection));
        end
        
        function [] = CalculateLongitudeCorrection(obj)
            %4'ün önündeki iþaret konum greenwich'in doðusundaysa - (eksi)
            %batýsýnda ise + (artý) olmalý
             obj.LongitudeCorrection= -4*(obj.StandardLongitude - obj.LocalLongitude);
        end
        
        function [] = CalculateEquationOfTime(obj)
            %B fonsiyonu yardýmýyla hesaplanan deðeri baz alarak zaman denklemini hesaplar.
            B = obj.CalculateB();
            obj.EquationOfTime = 9.87*sind(2*B) - 7.53*cosd(B) - 1.5*sind(B);
        end
        
        function b = CalculateB(obj)
            b = (obj.DayOfTheYear - 81) * (360 / 364);
        end
        
        function [] = SetDayOfTheYear(obj)
            obj.DayOfTheYear = obj.Tool.DayOfTheYearFromGivenDate(obj.Date);
        end

    end
end