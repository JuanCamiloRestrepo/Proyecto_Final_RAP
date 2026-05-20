CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Item RESULT result.

    METHODS releaseItem FOR MODIFY
      IMPORTING keys FOR ACTION Item~releaseItem RESULT result.

    METHODS setItemID FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~setItemID.
    METHODS discontinueItem FOR MODIFY
      IMPORTING keys FOR ACTION Item~discontinueItem RESULT result.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    BY \_Items
    FIELDS ( ReleaseDate DiscontinuedDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(items).

    result = VALUE #( FOR item IN items ( %tky = item-%tky
                                          %action-releaseItem = COND #( WHEN item-DiscontinuedDate IS INITIAL
                                                                        THEN if_abap_behv=>fc-o-enabled
                                                                        ELSE if_abap_behv=>fc-o-disabled )
                                          %action-discontinueItem = COND #( WHEN item-ReleaseDate IS INITIAL
                                                                            THEN if_abap_behv=>fc-o-enabled
                                                                            ELSE if_abap_behv=>fc-o-disabled ) ) ).

  ENDMETHOD.

  METHOD releaseItem.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    FIELDS ( ReleaseDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(items).

    DELETE items WHERE ReleaseDate IS NOT INITIAL.

    CHECK items IS NOT INITIAL.

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    UPDATE
    FIELDS ( ReleaseDate )
    WITH VALUE #( FOR item IN items ( %tky        = item-%tky
                                      ReleaseDate = cl_abap_context_info=>get_system_date(  ) ) ).

  ENDMETHOD.

  METHOD setItemID.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    FIELDS ( ItemID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(items).

    DELETE items WHERE ItemID IS NOT INITIAL.

    CHECK items IS NOT INITIAL.

    SELECT SINGLE FROM zitems_1241
    FIELDS MAX( item_id )
    INTO @DATA(max_ItemID).

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    UPDATE
    FIELDS ( ItemID )
    WITH VALUE #( FOR item IN items INDEX INTO i ( %tky      = item-%tky
                                                   ItemID    = max_itemid + i ) ).

  ENDMETHOD.

  METHOD discontinueItem.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    FIELDS ( DiscontinuedDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(items).

    DELETE items WHERE DiscontinuedDate IS NOT INITIAL.

    CHECK items IS NOT INITIAL.

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Item
    UPDATE
    FIELDS ( DiscontinuedDate )
    WITH VALUE #( FOR item IN items ( %tky             = item-%tky
                                      DiscontinuedDate = cl_abap_context_info=>get_system_date(  ) ) ).

  ENDMETHOD.

ENDCLASS.
