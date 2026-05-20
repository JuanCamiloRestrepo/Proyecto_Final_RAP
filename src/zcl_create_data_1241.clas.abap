CLASS zcl_create_data_1241 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_data_1241 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_statustext TYPE STANDARD TABLE OF zstatustext_1241.

    DELETE FROM zstatustext_1241.

    lt_statustext = VALUE #( ( orderstatus = 1 orderstatustext = 'Open' )
                             ( orderstatus = 2 orderstatustext = 'Partially Processed' )
                             ( orderstatus = 3 orderstatustext = 'Completed' )
                             ( orderstatus = 4 orderstatustext = 'Rejected' )
                             ( orderstatus = 5 orderstatustext = 'Blocked' )
                             ( orderstatus = 6 orderstatustext = 'In Process' ) ).

    INSERT zstatustext_1241 FROM TABLE @lt_statustext.
    out->write( 'Adding Order Status Text data' ).

  ENDMETHOD.
ENDCLASS.
