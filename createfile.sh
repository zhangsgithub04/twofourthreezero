#!/bin/bash
set -x
extension="ts"
prefix="joy"
importfile="../importfile"
touch $importfile
themecomponentfile="../themecomponent"
touch $themecomponentfile

function addimport()
{
	
	importline="import $1 from \"./$2\"" 
	echo $importline
	echo $importline >> "$importfile"

}

function addtotheme()
{
	componentline="...$1" 
	echo $componentline
	echo $componentline >> "$themecomponentfile"

}

function prototype()
{
	echo $0 $1 $2
cat << EOL > $1 

	const  Joy$2 = { 
		defaultProps: {
			size: 'sm',
		},
		 styleOverrides: {
        		root: ({ ownerState, theme }) => ({
          			...{
			            fontSize: theme.vars.fontSize.xs,
       		}}),	
		}
	}

EOL
return
}


function createfiles()
{
	dir=$1
	cd $dir 
	shift 
	components=("$@")
	for c in "${components[@]}"; do
    		fn="${c}.${extension}"
		prefixed=$prefix$c	
    		touch $fn
		prototype $fn $c 
		addimport $prefixed $dir/$c $dir $c
		addtotheme $prefixed 
	done
	cd ..
}

dirs=("INPUTS" "DATADISPLAY" "FEEDBACK" "SURFACES" "NAVIGATION" "LAYOUT" "UTILS")
for d in "${dirs[@]}"; do
	if [ ! -d $d ]; 
		then mkdir $d; 
	fi;
done;

components=("Autocomplete" "Button" "ButtonGroup" "Checkbox" "Input" "RadioButton" "Select" "Slider" "Switch" "Textarea" "ToggleButtonGroup")
createfiles INPUTS "${components[@]}"

components=("AspectRatio" "Avatar" "Badge" "Chip" "Divider" "List" "Table" "Tooltip" "Typography")
createfiles DATADISPLAY "${components[@]}"

components=("Alert" "CircularProgress" "LinearProgress" "Modal" "Skeleton" "Snackbar") 
createfiles  FEEDBACK "${components[@]}"

components=("Accordion" "Card" "Sheet")
createfiles  SURFACES "${components[@]}"

components=("Breadcrumbs" "Drawer" "Link" "Menu" "Stepper" "Tabs")
createfiles  NAVIGATION "${components[@]}"

components=("Box" "Grid" "Stack")
createfiles LAYOUT "${components[@]}"

components=("CSSBaseline")
createfiles UTILS "${components[@]}"

set +x
