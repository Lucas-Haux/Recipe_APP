abstract class DisplayableEnum {
  String get displayName;
}

abstract class ChipModeCollection {}

enum MealType { dinner, lunch, breakfast, snack }

enum CuisineType implements DisplayableEnum {
  african("African"),
  asian("Asian"),
  american("American"),
  british("British"),
  cajun("Cajun"),
  caribbean("Caribbean"),
  chinese("Chinese"),
  easternEuropean("Eastern European"),
  european("European"),
  french("French"),
  german("German"),
  greek("Greek"),
  indian("Indian"),
  irish("Irish"),
  italian("Italian"),
  japanese("Japanese"),
  jewish("Jewish"),
  korean("Korean"),
  latinAmerican("Latin American"),
  mediterranean("Mediterranean"),
  mexican("Mexican"),
  middleEastern("Middle Eastern"),
  nordic("Nordic"),
  southern("Southern"),
  spanish("Spanish"),
  thai("Thai"),
  vietnamese("Vietnamese");

  @override
  final String displayName;
  const CuisineType(this.displayName);
}

enum DietType implements DisplayableEnum {
  glutenFree("Gluten Free"),
  ketogenic("Ketogenic"),
  vegetarian("Vegetarian"),
  lactoVegetarian("Lacto-Vegetarian"),
  ovoVegetarian("Ovo-Vegetarian"),
  vegan("Vegan"),
  pescetarian("Pescetarian"),
  paleo("Paleo"),
  primal("Primal"),
  lowFodmap("Low FODMAP"),
  whole30("Whole30");

  @override
  final String displayName;
  const DietType(this.displayName);
}

enum IntoleranceType implements DisplayableEnum {
  dairy("Dairy"),
  egg("Egg"),
  gluten("Gluten"),
  grain("Grain"),
  peanut("Peanut"),
  seafood("Seafood"),
  sesame("Sesame"),
  shellfish("Shellfish"),
  soy("Soy"),
  sulfite("Sulfite"),
  treeNut("Tree Nut"),
  wheat("Wheat");

  @override
  final String displayName;
  const IntoleranceType(this.displayName);
}

enum AndOrType implements ChipModeCollection { and, or, unspecified }

enum InstructionView {
  list,
  paragraph,
}

enum RequireExclude implements ChipModeCollection {
  require,
  exclude,
  unspecified
}

enum ChipMode { requireExclude, and, orAnd }
