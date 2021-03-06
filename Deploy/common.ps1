#Common NuGet/Archiving logic, not meant ot be executed directly.

$framework = '4.0'

task default -depends Pack,Archive

task Init {
	cls
}

task Clean -depends Init {
	
	if (Test-Path $ArchiveDir) {
		ri $ArchiveDir -Recurse
	}
	
	ri SpecsFor.*.nupkg
	ri specsfor*.zip -ea SilentlyContinue
}

task Build -depends Init,Clean {
	exec { msbuild $SolutionFile }
}

#This function can be overriden to add additional logic to the archive process.
function OnArchiving {
}

task Archive -depends Build {
	mkdir $ArchiveDir
		
	$ZipFiles | %{cp $_ "$ArchiveDir" }
	
	OnArchiving
	
	Write-Zip -Path "$ArchiveDir\*" -OutputPath $ZipName
}

task Pack -depends Build {

	exec { nuget pack "$ProjectPath" -Version "$Version" }
}

task Publish -depends Pack {
	$PackageName = gci *.nupkg
	#We don't care if deleting fails..
	nuget delete $NuGetPackageName $Version -NoPrompt
	exec { nuget push $PackageName }
}