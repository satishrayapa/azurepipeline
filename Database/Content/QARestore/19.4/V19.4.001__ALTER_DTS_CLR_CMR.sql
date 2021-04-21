USE DTS

--Coming from DTS repo, ogt-legacy_dts,   DPSSearchAlgorithm/Bin/Debug/DPSSearchAlgorithm.dll, or Nuget reference "DPSSearchAlgorithm"
--ALTER ASSEMBLY DPSSearchAlgorithm FROM 'D:\SQL Server\SQLCLR\DPSSearchAlgorithm.dll' WITH PERMISSION_SET = SAFE; --Production location

IF EXISTS(SELECT * FROM SYS.OBJECTS where name = 'QuickScanAdjustableFilter')
DROP FUNCTION dbo.QuickScanAdjustableFilter
GO
CREATE FUNCTION [dbo].[QuickScanAdjustableFilter](@Data [nvarchar](4000), @Input [nvarchar](4000), @PreFilter DECIMAL(18, 2))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [DPSSearchAlgorithm].[DPSSearchAlgorithm.Utils].[QuickScanAdjustableFilter]
GO


--This would error if this script wasn't successful:
SELECT dbo.QuickCommon('BIN LADEN, Hamza', 'Bin Laden')

--QuickCommon should still function as usual
SELECT dbo.QuickScanAdjustableFilter('BIN LADEN, Hamza', 'Bin Laden', 0.75)
