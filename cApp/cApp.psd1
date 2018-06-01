@{

	RootModule = 'CApp.psm1'
	ModuleVersion = '1.0'
	GUID = '<%=$PLASTER_Guid1%>'
	Author = '<%=$PLASTER_PARAM_ProgramAuthor%>'
	CompanyName = 'Processa SAS'
	Copyright = '(c) <%=$PLASTER_Year%> Processa SAS. All rights reserved.'
	Description = '<%=$PLASTER_PARAM_ProgramDesc%>'
	PowerShellVersion = '5.0'
	DotNetFrameworkVersion = '4.0'
	CLRVersion = '4.0'
	RequiredModules = @('PSProcessa','Carbon')
	FunctionsToExport = '*'
	CmdletsToExport = '*'
	VariablesToExport = '*'
	AliasesToExport = '*'
	FormatsToProcess   = @('CApp-Format.ps1xml')
}
