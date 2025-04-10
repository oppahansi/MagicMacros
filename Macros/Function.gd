@tool
extends MagicMacrosMacro

const ALIASES: Array[String] = ["fn", "fnc"]

static var s: String
static var identifiers: Array[String]
static var types: Array[String]

static func is_macro_alias(arg: String) -> bool:
	return arg in ALIASES


static func apply_macro(line_data: MagicMacrosLineData) -> String:
	identifiers = line_data.identifier_args.duplicate()
	types = line_data.type_args.duplicate()
	
	var function_name: String = identifiers[0]
	var return_type: String = types[types.size() - 1]
	var method_parameters: String = create_parameters(true)
	
	s  = "func %s(%s) -> %s:\n" % [function_name, method_parameters, return_type]
	s += "	pass\n\n"
	
	return s


static func create_parameters(method_signature: bool) -> String:
	var parameters: String = ""
	var template: String = "%s: %s"
	
	for i in types.size() - 1:
		if method_signature:
			parameters += template % [identifiers[i + 1], types[i]]
			
		if i < types.size() - 2:
			parameters += ", "
	
	return parameters
