use master;
GO


IF DB_ID ('comercializadora') IS NOT NULL
BEGIN

    DROP DATABASE comercializadora;
END
