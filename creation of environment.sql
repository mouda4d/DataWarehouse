use testScripts;
GO
EXEC CreateTables;
EXEC CreateConstraintsAndRelationships;
EXEC CreateSource_p;
EXEC CreateRandomDataGeneratorForSource_p;

