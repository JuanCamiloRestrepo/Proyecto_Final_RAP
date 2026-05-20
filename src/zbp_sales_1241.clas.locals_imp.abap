CLASS lhc_Sales DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF sales_order_status,
        open                TYPE int1 value 1,
        partially_processed TYPE int1 value 2,
        completed           TYPE int1 value 3,
        rejected            TYPE int1 value 4,
        blocked             TYPE int1 value 5,
        in_process          TYPE int1 value 6,
      END OF sales_order_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Sale RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Sale RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Sale RESULT result.

    METHODS resume FOR MODIFY
      IMPORTING keys FOR ACTION Sale~resume.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Sale~setStatusToOpen.

    METHODS setSalesOrder FOR DETERMINE ON SAVE
      IMPORTING keys FOR Sale~setSalesOrder.

    methods rejectOrder for modify
        importing keys for action Sale~rejectOrder result result.
    methods setCreationDate for determine on modify
      importing keys for Sale~setCreationDate.

ENDCLASS.

CLASS lhc_Sales IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    FIELDS ( OrderStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    result = VALUE #( FOR sale IN sales ( %tky                = sale-%tky
                                          %action-rejectOrder = COND #( WHEN sale-OrderStatus = sales_order_status-rejected OR
                                                                             sale-OrderStatus = sales_order_status-completed
                                                                        THEN if_abap_behv=>fc-o-disabled
                                                                        ELSE if_abap_behv=>fc-o-enabled )
                                          %assoc-_Items       = COND #( WHEN sale-OrderStatus = sales_order_status-rejected
                                                                        THEN if_abap_behv=>fc-o-disabled
                                                                        ELSE if_abap_behv=>fc-o-enabled ) ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD resume.
  ENDMETHOD.

  METHOD setStatusToOpen.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    FIELDS ( OrderStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    DELETE sales WHERE OrderStatus IS NOT INITIAL.

    CHECK sales IS NOT INITIAL.

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    UPDATE
    FIELDS ( OrderStatus )
    WITH VALUE #( FOR sale IN sales ( %tky = sale-%tky
                                      OrderStatus = sales_order_status-open ) ).

  ENDMETHOD.

  METHOD setSalesOrder.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    FIELDS ( SalesID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    DELETE sales WHERE SalesID IS NOT INITIAL.

    CHECK sales IS NOT INITIAL.

    SELECT SINGLE FROM zsales_r_1241
    FIELDS MAX( SalesID )
    INTO @DATA(max_SalesID).

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    UPDATE
    FIELDS ( SalesID )
    WITH VALUE #( FOR sale IN sales INDEX INTO i ( %tky = sale-%tky
                                                   SalesID = max_salesid + i ) ).

  ENDMETHOD.

  METHOD rejectorder.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    FIELDS ( OrderStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    DELETE sales WHERE OrderStatus EQ 3.
    DELETE sales WHERE OrderStatus EQ 4.

    CHECK sales IS NOT INITIAL.

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    UPDATE
    FIELDS ( OrderStatus )
    WITH VALUE #( FOR sale IN sales ( %tky        = sale-%tky
                                      OrderStatus = 4 ) ).

  ENDMETHOD.

  METHOD setCreationDate.

    READ ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    FIELDS ( CreatedOn )
    WITH CORRESPONDING #( keys )
    RESULT DATA(sales).

    DELETE sales WHERE CreatedOn IS NOT INITIAL.

    CHECK sales IS NOT INITIAL.

    MODIFY ENTITIES OF zsales_r_1241 IN LOCAL MODE
    ENTITY Sale
    UPDATE
    FIELDS ( CreatedOn )
    WITH VALUE #( FOR sale IN sales ( %tky      = sale-%tky
                                      CreatedOn = cl_abap_context_info=>get_system_date(  ) ) ).

  ENDMETHOD.

ENDCLASS.
