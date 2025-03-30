abstract class ChipParametersMode {}

enum AndOrType implements ChipParametersMode { and, or, unspecified }

enum RequireExclude implements ChipParametersMode {
  require,
  exclude,
  unspecified
}
