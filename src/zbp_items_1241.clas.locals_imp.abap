CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Item RESULT result.

    METHODS releaseItem FOR MODIFY
      IMPORTING keys FOR ACTION Item~releaseItem RESULT result.

    METHODS setItemID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Item~setItemID.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD releaseItem.
  ENDMETHOD.

  METHOD setItemID.



  ENDMETHOD.

ENDCLASS.
