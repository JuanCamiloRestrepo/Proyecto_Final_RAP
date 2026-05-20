@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Unit Of Measure - Length'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity ZUOM_LENGTH_1241 
    as select from I_UnitOfMeasure
{   
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    key UnitOfMeasure as uom,
    @Semantics.text: true
        UnitOfMeasure_E as uom_text
}
where UnitOfMeasureDimension = 'LENGTH'
