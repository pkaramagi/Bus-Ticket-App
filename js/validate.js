function checkRequired( elem ) {
if ( elem.type == "checkbox" || elem.type == "radio" )
return getInputsByName( elem.name ).numChecked;
else
return elem.value.length > 0 && elem.value != elem.defaultValue;
}

