// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      sourceName: fields[3] as String,
      sourceUrl: fields[4] as String,
      time: fields[5] as int,
      servings: fields[6] as int,
      pricePerServing: fields[7] as double,
      popular: fields[8] as bool,
      vegan: fields[10] as bool,
      vegetarian: fields[9] as bool,
      cuisines: (fields[11] as List).cast<dynamic>(),
      dishTypes: (fields[12] as List).cast<dynamic>(),
      diets: (fields[13] as List).cast<dynamic>(),
      ingredients: (fields[14] as List).cast<String>(),
      instructions: (fields[15] as List).cast<InstructionModel>(),
      calories: fields[16] as String,
      protein: fields[17] as String,
      fat: fields[18] as String,
      healthScore: fields[19] as int,
      weightWatcher: fields[20] as int,
      summary: fields[21] as String,
      instructionsParagraph: fields[22] as String?,
      nutrients: (fields[23] as List?)?.cast<NutritionModel>(),
      similarRecipes: (fields[24] as List?)?.cast<SimilarRecipeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.sourceName)
      ..writeByte(4)
      ..write(obj.sourceUrl)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.servings)
      ..writeByte(7)
      ..write(obj.pricePerServing)
      ..writeByte(8)
      ..write(obj.popular)
      ..writeByte(9)
      ..write(obj.vegetarian)
      ..writeByte(10)
      ..write(obj.vegan)
      ..writeByte(11)
      ..write(obj.cuisines)
      ..writeByte(12)
      ..write(obj.dishTypes)
      ..writeByte(13)
      ..write(obj.diets)
      ..writeByte(14)
      ..write(obj.ingredients)
      ..writeByte(15)
      ..write(obj.instructions)
      ..writeByte(16)
      ..write(obj.calories)
      ..writeByte(17)
      ..write(obj.protein)
      ..writeByte(18)
      ..write(obj.fat)
      ..writeByte(19)
      ..write(obj.healthScore)
      ..writeByte(20)
      ..write(obj.weightWatcher)
      ..writeByte(21)
      ..write(obj.summary)
      ..writeByte(22)
      ..write(obj.instructionsParagraph)
      ..writeByte(23)
      ..write(obj.nutrients)
      ..writeByte(24)
      ..write(obj.similarRecipes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InstructionModelAdapter extends TypeAdapter<InstructionModel> {
  @override
  final int typeId = 1;

  @override
  InstructionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InstructionModel(
      title: fields[0] as String,
      steps: (fields[1] as List).cast<StepModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, InstructionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstructionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StepModelAdapter extends TypeAdapter<StepModel> {
  @override
  final int typeId = 2;

  @override
  StepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepModel(
      ingredents: (fields[2] as List).cast<String>(),
      equipment: (fields[3] as List).cast<String>(),
      stepNumber: fields[0] as int,
      stepInstruction: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StepModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.stepNumber)
      ..writeByte(1)
      ..write(obj.stepInstruction)
      ..writeByte(2)
      ..write(obj.ingredents)
      ..writeByte(3)
      ..write(obj.equipment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NutritionModelAdapter extends TypeAdapter<NutritionModel> {
  @override
  final int typeId = 3;

  @override
  NutritionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionModel(
      label: fields[0] as String,
      amount: fields[1] as double,
      unit: fields[2] as String,
      percentage: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.percentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SimilarRecipeModelAdapter extends TypeAdapter<SimilarRecipeModel> {
  @override
  final int typeId = 4;

  @override
  SimilarRecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimilarRecipeModel(
      id: fields[0] as int,
      title: fields[1] as String,
      time: fields[2] as int,
      servings: fields[3] as int,
      imageUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SimilarRecipeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.servings)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimilarRecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
