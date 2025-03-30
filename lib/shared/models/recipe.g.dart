// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecipeCollection on Isar {
  IsarCollection<Recipe> get recipes => this.collection();
}

const RecipeSchema = CollectionSchema(
  name: r'Recipe',
  id: 8054415271972849591,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.long,
    ),
    r'cuisines': PropertySchema(
      id: 1,
      name: r'cuisines',
      type: IsarType.stringList,
    ),
    r'diets': PropertySchema(
      id: 2,
      name: r'diets',
      type: IsarType.stringList,
    ),
    r'dishTypes': PropertySchema(
      id: 3,
      name: r'dishTypes',
      type: IsarType.stringList,
    ),
    r'fat': PropertySchema(
      id: 4,
      name: r'fat',
      type: IsarType.long,
    ),
    r'healthScore': PropertySchema(
      id: 5,
      name: r'healthScore',
      type: IsarType.double,
    ),
    r'imageUrl': PropertySchema(
      id: 6,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'ingredients': PropertySchema(
      id: 7,
      name: r'ingredients',
      type: IsarType.stringList,
    ),
    r'instructions': PropertySchema(
      id: 8,
      name: r'instructions',
      type: IsarType.objectList,
      target: r'Instruction',
    ),
    r'instructionsParagraph': PropertySchema(
      id: 9,
      name: r'instructionsParagraph',
      type: IsarType.string,
    ),
    r'nutrients': PropertySchema(
      id: 10,
      name: r'nutrients',
      type: IsarType.objectList,
      target: r'NutritionModel',
    ),
    r'popular': PropertySchema(
      id: 11,
      name: r'popular',
      type: IsarType.bool,
    ),
    r'pricePerServing': PropertySchema(
      id: 12,
      name: r'pricePerServing',
      type: IsarType.double,
    ),
    r'protein': PropertySchema(
      id: 13,
      name: r'protein',
      type: IsarType.long,
    ),
    r'recipeId': PropertySchema(
      id: 14,
      name: r'recipeId',
      type: IsarType.long,
    ),
    r'servings': PropertySchema(
      id: 15,
      name: r'servings',
      type: IsarType.long,
    ),
    r'similarRecipes': PropertySchema(
      id: 16,
      name: r'similarRecipes',
      type: IsarType.objectList,
      target: r'SimilarRecipe',
    ),
    r'sourceName': PropertySchema(
      id: 17,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'sourceUrl': PropertySchema(
      id: 18,
      name: r'sourceUrl',
      type: IsarType.string,
    ),
    r'summary': PropertySchema(
      id: 19,
      name: r'summary',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 20,
      name: r'time',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 21,
      name: r'title',
      type: IsarType.string,
    ),
    r'vegan': PropertySchema(
      id: 22,
      name: r'vegan',
      type: IsarType.bool,
    ),
    r'vegetarian': PropertySchema(
      id: 23,
      name: r'vegetarian',
      type: IsarType.bool,
    ),
    r'weightWatcher': PropertySchema(
      id: 24,
      name: r'weightWatcher',
      type: IsarType.long,
    )
  },
  estimateSize: _recipeEstimateSize,
  serialize: _recipeSerialize,
  deserialize: _recipeDeserialize,
  deserializeProp: _recipeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'SimilarRecipe': SimilarRecipeSchema,
    r'NutritionModel': NutritionModelSchema,
    r'Instruction': InstructionSchema,
    r'InstructionStep': InstructionStepSchema
  },
  getId: _recipeGetId,
  getLinks: _recipeGetLinks,
  attach: _recipeAttach,
  version: '3.1.8',
);

int _recipeEstimateSize(
  Recipe object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cuisines.length * 3;
  {
    for (var i = 0; i < object.cuisines.length; i++) {
      final value = object.cuisines[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.diets.length * 3;
  {
    for (var i = 0; i < object.diets.length; i++) {
      final value = object.diets[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.dishTypes.length * 3;
  {
    for (var i = 0; i < object.dishTypes.length; i++) {
      final value = object.dishTypes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.imageUrl.length * 3;
  bytesCount += 3 + object.ingredients.length * 3;
  {
    for (var i = 0; i < object.ingredients.length; i++) {
      final value = object.ingredients[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.instructions.length * 3;
  {
    final offsets = allOffsets[Instruction]!;
    for (var i = 0; i < object.instructions.length; i++) {
      final value = object.instructions[i];
      bytesCount += InstructionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.instructionsParagraph;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.nutrients;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[NutritionModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              NutritionModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.similarRecipes;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[SimilarRecipe]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              SimilarRecipeSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.sourceName.length * 3;
  bytesCount += 3 + object.sourceUrl.length * 3;
  bytesCount += 3 + object.summary.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _recipeSerialize(
  Recipe object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.calories);
  writer.writeStringList(offsets[1], object.cuisines);
  writer.writeStringList(offsets[2], object.diets);
  writer.writeStringList(offsets[3], object.dishTypes);
  writer.writeLong(offsets[4], object.fat);
  writer.writeDouble(offsets[5], object.healthScore);
  writer.writeString(offsets[6], object.imageUrl);
  writer.writeStringList(offsets[7], object.ingredients);
  writer.writeObjectList<Instruction>(
    offsets[8],
    allOffsets,
    InstructionSchema.serialize,
    object.instructions,
  );
  writer.writeString(offsets[9], object.instructionsParagraph);
  writer.writeObjectList<NutritionModel>(
    offsets[10],
    allOffsets,
    NutritionModelSchema.serialize,
    object.nutrients,
  );
  writer.writeBool(offsets[11], object.popular);
  writer.writeDouble(offsets[12], object.pricePerServing);
  writer.writeLong(offsets[13], object.protein);
  writer.writeLong(offsets[14], object.recipeId);
  writer.writeLong(offsets[15], object.servings);
  writer.writeObjectList<SimilarRecipe>(
    offsets[16],
    allOffsets,
    SimilarRecipeSchema.serialize,
    object.similarRecipes,
  );
  writer.writeString(offsets[17], object.sourceName);
  writer.writeString(offsets[18], object.sourceUrl);
  writer.writeString(offsets[19], object.summary);
  writer.writeLong(offsets[20], object.time);
  writer.writeString(offsets[21], object.title);
  writer.writeBool(offsets[22], object.vegan);
  writer.writeBool(offsets[23], object.vegetarian);
  writer.writeLong(offsets[24], object.weightWatcher);
}

Recipe _recipeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Recipe(
    calories: reader.readLong(offsets[0]),
    cuisines: reader.readStringList(offsets[1]) ?? [],
    diets: reader.readStringList(offsets[2]) ?? [],
    dishTypes: reader.readStringList(offsets[3]) ?? [],
    fat: reader.readLong(offsets[4]),
    healthScore: reader.readDouble(offsets[5]),
    imageUrl: reader.readString(offsets[6]),
    ingredients: reader.readStringList(offsets[7]) ?? [],
    instructions: reader.readObjectList<Instruction>(
          offsets[8],
          InstructionSchema.deserialize,
          allOffsets,
          Instruction(),
        ) ??
        [],
    instructionsParagraph: reader.readStringOrNull(offsets[9]),
    nutrients: reader.readObjectList<NutritionModel>(
      offsets[10],
      NutritionModelSchema.deserialize,
      allOffsets,
      NutritionModel(),
    ),
    popular: reader.readBool(offsets[11]),
    pricePerServing: reader.readDouble(offsets[12]),
    protein: reader.readLong(offsets[13]),
    recipeId: reader.readLong(offsets[14]),
    servings: reader.readLong(offsets[15]),
    similarRecipes: reader.readObjectList<SimilarRecipe>(
      offsets[16],
      SimilarRecipeSchema.deserialize,
      allOffsets,
      SimilarRecipe(),
    ),
    sourceName: reader.readString(offsets[17]),
    sourceUrl: reader.readString(offsets[18]),
    summary: reader.readString(offsets[19]),
    time: reader.readLong(offsets[20]),
    title: reader.readString(offsets[21]),
    vegan: reader.readBool(offsets[22]),
    vegetarian: reader.readBool(offsets[23]),
    weightWatcher: reader.readLong(offsets[24]),
  );
  object.id = id;
  return object;
}

P _recipeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readObjectList<Instruction>(
            offset,
            InstructionSchema.deserialize,
            allOffsets,
            Instruction(),
          ) ??
          []) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readObjectList<NutritionModel>(
        offset,
        NutritionModelSchema.deserialize,
        allOffsets,
        NutritionModel(),
      )) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readObjectList<SimilarRecipe>(
        offset,
        SimilarRecipeSchema.deserialize,
        allOffsets,
        SimilarRecipe(),
      )) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recipeGetId(Recipe object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _recipeGetLinks(Recipe object) {
  return [];
}

void _recipeAttach(IsarCollection<dynamic> col, Id id, Recipe object) {
  object.id = id;
}

extension RecipeQueryWhereSort on QueryBuilder<Recipe, Recipe, QWhere> {
  QueryBuilder<Recipe, Recipe, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecipeQueryWhere on QueryBuilder<Recipe, Recipe, QWhereClause> {
  QueryBuilder<Recipe, Recipe, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecipeQueryFilter on QueryBuilder<Recipe, Recipe, QFilterCondition> {
  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> caloriesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> caloriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> caloriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> caloriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      cuisinesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuisines',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuisines',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuisines',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuisines',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      cuisinesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuisines',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> cuisinesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cuisines',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'diets',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'diets',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diets',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'diets',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dietsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'diets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      dishTypesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dishTypes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      dishTypesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dishTypes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dishTypes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      dishTypesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dishTypes',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      dishTypesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dishTypes',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      dishTypesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> dishTypesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dishTypes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> fatEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fat',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> fatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fat',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> fatLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fat',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> fatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> healthScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> healthScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> healthScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> healthScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingredients',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredients',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredients',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredients',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      ingredientsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> ingredientsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredients',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> instructionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> instructionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> instructionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> instructionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instructions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'instructionsParagraph',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'instructionsParagraph',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instructionsParagraph',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'instructionsParagraph',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'instructionsParagraph',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instructionsParagraph',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      instructionsParagraphIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'instructionsParagraph',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nutrients',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nutrients',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      nutrientsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> popularEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'popular',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> pricePerServingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pricePerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      pricePerServingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pricePerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> pricePerServingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pricePerServing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> pricePerServingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pricePerServing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> proteinEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protein',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> proteinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protein',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> proteinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protein',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> proteinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> recipeIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> recipeIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> recipeIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> recipeIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recipeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> servingsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> servingsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> servingsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> servingsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> similarRecipesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'similarRecipes',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'similarRecipes',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> similarRecipesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition>
      similarRecipesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'similarRecipes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> sourceUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> timeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> timeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> timeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> timeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> veganEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vegan',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> vegetarianEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vegetarian',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> weightWatcherEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightWatcher',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> weightWatcherGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightWatcher',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> weightWatcherLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightWatcher',
        value: value,
      ));
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> weightWatcherBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightWatcher',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecipeQueryObject on QueryBuilder<Recipe, Recipe, QFilterCondition> {
  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> instructionsElement(
      FilterQuery<Instruction> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'instructions');
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> nutrientsElement(
      FilterQuery<NutritionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrients');
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterFilterCondition> similarRecipesElement(
      FilterQuery<SimilarRecipe> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'similarRecipes');
    });
  }
}

extension RecipeQueryLinks on QueryBuilder<Recipe, Recipe, QFilterCondition> {}

extension RecipeQuerySortBy on QueryBuilder<Recipe, Recipe, QSortBy> {
  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fat', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fat', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByHealthScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByInstructionsParagraph() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsParagraph', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByInstructionsParagraphDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsParagraph', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByPricePerServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerServing', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByPricePerServingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerServing', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByServingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySourceUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySourceUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByVegan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegan', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByVeganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegan', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByVegetarian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegetarian', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByVegetarianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegetarian', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByWeightWatcher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightWatcher', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> sortByWeightWatcherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightWatcher', Sort.desc);
    });
  }
}

extension RecipeQuerySortThenBy on QueryBuilder<Recipe, Recipe, QSortThenBy> {
  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fat', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fat', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByHealthScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByInstructionsParagraph() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsParagraph', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByInstructionsParagraphDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instructionsParagraph', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByPopularDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popular', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByPricePerServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerServing', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByPricePerServingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pricePerServing', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protein', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByServingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'servings', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySourceUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySourceUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByVegan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegan', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByVeganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegan', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByVegetarian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegetarian', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByVegetarianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vegetarian', Sort.desc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByWeightWatcher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightWatcher', Sort.asc);
    });
  }

  QueryBuilder<Recipe, Recipe, QAfterSortBy> thenByWeightWatcherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightWatcher', Sort.desc);
    });
  }
}

extension RecipeQueryWhereDistinct on QueryBuilder<Recipe, Recipe, QDistinct> {
  QueryBuilder<Recipe, Recipe, QDistinct> distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByCuisines() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuisines');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByDiets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diets');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByDishTypes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dishTypes');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fat');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthScore');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByIngredients() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingredients');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByInstructionsParagraph(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instructionsParagraph',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByPopular() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'popular');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByPricePerServing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pricePerServing');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protein');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recipeId');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByServings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'servings');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctBySourceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctBySourceUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctBySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByVegan() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vegan');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByVegetarian() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vegetarian');
    });
  }

  QueryBuilder<Recipe, Recipe, QDistinct> distinctByWeightWatcher() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightWatcher');
    });
  }
}

extension RecipeQueryProperty on QueryBuilder<Recipe, Recipe, QQueryProperty> {
  QueryBuilder<Recipe, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<Recipe, List<String>, QQueryOperations> cuisinesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuisines');
    });
  }

  QueryBuilder<Recipe, List<String>, QQueryOperations> dietsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diets');
    });
  }

  QueryBuilder<Recipe, List<String>, QQueryOperations> dishTypesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dishTypes');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> fatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fat');
    });
  }

  QueryBuilder<Recipe, double, QQueryOperations> healthScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthScore');
    });
  }

  QueryBuilder<Recipe, String, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<Recipe, List<String>, QQueryOperations> ingredientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingredients');
    });
  }

  QueryBuilder<Recipe, List<Instruction>, QQueryOperations>
      instructionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructions');
    });
  }

  QueryBuilder<Recipe, String?, QQueryOperations>
      instructionsParagraphProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instructionsParagraph');
    });
  }

  QueryBuilder<Recipe, List<NutritionModel>?, QQueryOperations>
      nutrientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrients');
    });
  }

  QueryBuilder<Recipe, bool, QQueryOperations> popularProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'popular');
    });
  }

  QueryBuilder<Recipe, double, QQueryOperations> pricePerServingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pricePerServing');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> proteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protein');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> recipeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipeId');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> servingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'servings');
    });
  }

  QueryBuilder<Recipe, List<SimilarRecipe>?, QQueryOperations>
      similarRecipesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'similarRecipes');
    });
  }

  QueryBuilder<Recipe, String, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<Recipe, String, QQueryOperations> sourceUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceUrl');
    });
  }

  QueryBuilder<Recipe, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }

  QueryBuilder<Recipe, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Recipe, bool, QQueryOperations> veganProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vegan');
    });
  }

  QueryBuilder<Recipe, bool, QQueryOperations> vegetarianProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vegetarian');
    });
  }

  QueryBuilder<Recipe, int, QQueryOperations> weightWatcherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightWatcher');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SimilarRecipeSchema = Schema(
  name: r'SimilarRecipe',
  id: -2592511632756241124,
  properties: {
    r'imageUrl': PropertySchema(
      id: 0,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'recipeId': PropertySchema(
      id: 1,
      name: r'recipeId',
      type: IsarType.long,
    ),
    r'servings': PropertySchema(
      id: 2,
      name: r'servings',
      type: IsarType.long,
    ),
    r'time': PropertySchema(
      id: 3,
      name: r'time',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _similarRecipeEstimateSize,
  serialize: _similarRecipeSerialize,
  deserialize: _similarRecipeDeserialize,
  deserializeProp: _similarRecipeDeserializeProp,
);

int _similarRecipeEstimateSize(
  SimilarRecipe object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _similarRecipeSerialize(
  SimilarRecipe object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imageUrl);
  writer.writeLong(offsets[1], object.recipeId);
  writer.writeLong(offsets[2], object.servings);
  writer.writeLong(offsets[3], object.time);
  writer.writeString(offsets[4], object.title);
}

SimilarRecipe _similarRecipeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SimilarRecipe(
    imageUrl: reader.readStringOrNull(offsets[0]),
    recipeId: reader.readLongOrNull(offsets[1]),
    servings: reader.readLongOrNull(offsets[2]),
    time: reader.readLongOrNull(offsets[3]),
    title: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _similarRecipeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SimilarRecipeQueryFilter
    on QueryBuilder<SimilarRecipe, SimilarRecipe, QFilterCondition> {
  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recipeId',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recipeId',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recipeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      recipeIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recipeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'servings',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'servings',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'servings',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      servingsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'servings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      timeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      timeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition> timeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      timeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      timeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition> timeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<SimilarRecipe, SimilarRecipe, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension SimilarRecipeQueryObject
    on QueryBuilder<SimilarRecipe, SimilarRecipe, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InstructionSchema = Schema(
  name: r'Instruction',
  id: 4657070553429627997,
  properties: {
    r'steps': PropertySchema(
      id: 0,
      name: r'steps',
      type: IsarType.objectList,
      target: r'InstructionStep',
    ),
    r'title': PropertySchema(
      id: 1,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _instructionEstimateSize,
  serialize: _instructionSerialize,
  deserialize: _instructionDeserialize,
  deserializeProp: _instructionDeserializeProp,
);

int _instructionEstimateSize(
  Instruction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.steps;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[InstructionStep]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              InstructionStepSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _instructionSerialize(
  Instruction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<InstructionStep>(
    offsets[0],
    allOffsets,
    InstructionStepSchema.serialize,
    object.steps,
  );
  writer.writeString(offsets[1], object.title);
}

Instruction _instructionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Instruction(
    steps: reader.readObjectList<InstructionStep>(
      offsets[0],
      InstructionStepSchema.deserialize,
      allOffsets,
      InstructionStep(),
    ),
    title: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _instructionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<InstructionStep>(
        offset,
        InstructionStepSchema.deserialize,
        allOffsets,
        InstructionStep(),
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InstructionQueryFilter
    on QueryBuilder<Instruction, Instruction, QFilterCondition> {
  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> stepsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'steps',
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> stepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      stepsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'steps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Instruction, Instruction, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension InstructionQueryObject
    on QueryBuilder<Instruction, Instruction, QFilterCondition> {
  QueryBuilder<Instruction, Instruction, QAfterFilterCondition> stepsElement(
      FilterQuery<InstructionStep> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'steps');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InstructionStepSchema = Schema(
  name: r'InstructionStep',
  id: 6997816664567108484,
  properties: {
    r'equipment': PropertySchema(
      id: 0,
      name: r'equipment',
      type: IsarType.stringList,
    ),
    r'ingredents': PropertySchema(
      id: 1,
      name: r'ingredents',
      type: IsarType.stringList,
    ),
    r'stepInstruction': PropertySchema(
      id: 2,
      name: r'stepInstruction',
      type: IsarType.string,
    ),
    r'stepNumber': PropertySchema(
      id: 3,
      name: r'stepNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _instructionStepEstimateSize,
  serialize: _instructionStepSerialize,
  deserialize: _instructionStepDeserialize,
  deserializeProp: _instructionStepDeserializeProp,
);

int _instructionStepEstimateSize(
  InstructionStep object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.equipment;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.ingredents;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.stepInstruction;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _instructionStepSerialize(
  InstructionStep object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.equipment);
  writer.writeStringList(offsets[1], object.ingredents);
  writer.writeString(offsets[2], object.stepInstruction);
  writer.writeLong(offsets[3], object.stepNumber);
}

InstructionStep _instructionStepDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InstructionStep(
    equipment: reader.readStringList(offsets[0]),
    ingredents: reader.readStringList(offsets[1]),
    stepInstruction: reader.readStringOrNull(offsets[2]),
    stepNumber: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _instructionStepDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InstructionStepQueryFilter
    on QueryBuilder<InstructionStep, InstructionStep, QFilterCondition> {
  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'equipment',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'equipment',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'equipment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'equipment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'equipment',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equipment',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'equipment',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      equipmentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'equipment',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ingredents',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ingredents',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingredents',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredents',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredents',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredents',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      ingredentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ingredents',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stepInstruction',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stepInstruction',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stepInstruction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stepInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stepInstruction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stepInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepInstructionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stepInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stepNumber',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stepNumber',
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stepNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stepNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stepNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<InstructionStep, InstructionStep, QAfterFilterCondition>
      stepNumberBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stepNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InstructionStepQueryObject
    on QueryBuilder<InstructionStep, InstructionStep, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const NutritionModelSchema = Schema(
  name: r'NutritionModel',
  id: -6549326112891492080,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'label': PropertySchema(
      id: 1,
      name: r'label',
      type: IsarType.string,
    ),
    r'percentage': PropertySchema(
      id: 2,
      name: r'percentage',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(
      id: 3,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _nutritionModelEstimateSize,
  serialize: _nutritionModelSerialize,
  deserialize: _nutritionModelDeserialize,
  deserializeProp: _nutritionModelDeserializeProp,
);

int _nutritionModelEstimateSize(
  NutritionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.label;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.unit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _nutritionModelSerialize(
  NutritionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeString(offsets[1], object.label);
  writer.writeDouble(offsets[2], object.percentage);
  writer.writeString(offsets[3], object.unit);
}

NutritionModel _nutritionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NutritionModel(
    amount: reader.readDoubleOrNull(offsets[0]),
    label: reader.readStringOrNull(offsets[1]),
    percentage: reader.readDoubleOrNull(offsets[2]),
    unit: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _nutritionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension NutritionModelQueryFilter
    on QueryBuilder<NutritionModel, NutritionModel, QFilterCondition> {
  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      amountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'percentage',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'percentage',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      percentageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<NutritionModel, NutritionModel, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension NutritionModelQueryObject
    on QueryBuilder<NutritionModel, NutritionModel, QFilterCondition> {}
