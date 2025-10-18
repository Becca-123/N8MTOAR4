CLASS ZZ1_CL_PREXPORTIV DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
*    INTERFACES if_amdp_marker_hdb.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_PREXPORTIV IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lwa_data TYPE zz1_i_prexportiv,
          lt_data  TYPE STANDARD TABLE OF zz1_i_prexportiv,
          lwa_data3 TYPE zz1_i_prexportiv,
          lt_data3  TYPE STANDARD TABLE OF zz1_i_prexportiv,
          lwa_data4 TYPE zz1_i_prexportiv,
          lt_data4  TYPE STANDARD TABLE OF zz1_i_prexportiv,
          lwa_data2 TYPE I_PurchaseRequisitionItemAPI01,
          lt_data2  TYPE STANDARD TABLE OF I_PurchaseRequisitionItemAPI01.
    DATA : lwa_acct TYPE I_PurReqnAcctAssgmtAPI01,
           lt_acct TYPE STANDARD TABLE OF I_PurReqnAcctAssgmtAPI01.
    DATA : l_num TYPE i,
           l_index TYPE sy-tabix,
           l_id TYPE i.
    "差額處理
    DATA : l_index_2 TYPE sy-tabix,
           l_num_2 TYPE I_PurchaseRequisitionItemAPI01-PurchaseRequisitionPrice,
           l_num_3 TYPE I_PurchaseRequisitionItemAPI01-PurchaseRequisitionPrice.
    lt_data = CORRESPONDING #( it_original_data ).
    SORT lt_data BY PurchaseRequisition PurchaseRequisitionitem ASCENDING.
    SELECT * FROM I_PurReqnAcctAssgmtAPI01
        FOR ALL ENTRIES IN @lt_data
        WHERE PurchaseRequisition = @lt_data-PurchaseRequisition AND PurchaseRequisitionitem = @lt_data-PurchaseRequisitionitem
        INTO CORRESPONDING FIELDS OF TABLE @lt_acct.
    SELECT * FROM I_PurchaseRequisitionItemAPI01
        FOR ALL ENTRIES IN @lt_data
        WHERE PurchaseRequisition = @lt_data-PurchaseRequisition AND PurchaseRequisitionitem = @lt_data-PurchaseRequisitionitem
        INTO CORRESPONDING FIELDS OF TABLE @lt_data2.
    LOOP AT lt_data INTO lwa_data.
        l_index = sy-tabix.
        CLEAR :lwa_data2.
        READ TABLE lt_data2 INTO lwa_data2 WITH KEY PurchaseRequisitionitem = lwa_data-PurchaseRequisitionitem PurchaseRequisition = lwa_data-PurchaseRequisition.
        lwa_data-yy1_count_pri = lwa_data2-yy1_count_pri.
        MODIFY lt_data FROM lwa_data INDEX l_index.
    ENDLOOP.
    l_num = 1.
    lt_data3 = lt_data.
    lt_data4 = lt_data.
    SORT lt_data4 BY PurchaseRequisition YY1_COUNT_PRI ASCENDING.
    DELETE ADJACENT DUPLICATES FROM lt_data4 COMPARING PurchaseRequisition YY1_COUNT_PRI.
    DELETE ADJACENT DUPLICATES FROM lt_data3 COMPARING PurchaseRequisition PurchaseRequisitionitem.
    CLEAR : l_id.
    LOOP AT lt_data4 INTO lwa_data4.
        l_id += 1.
        LOOP AT lt_data3 INTO lwa_data3 WHERE PurchaseRequisition = lwa_data4-PurchaseRequisition AND YY1_COUNT_PRI = lwa_data4-YY1_COUNT_PRI .
            CLEAR : l_num_2,l_num_3,l_index_2.
            LOOP AT lt_data INTO lwa_data WHERE PurchaseRequisition = lwa_data3-PurchaseRequisition AND PurchaseRequisitionitem = lwa_data3-PurchaseRequisitionitem.
              l_index = sy-tabix.
*              l_num = lwa_data-text1+17(2).
              lwa_data-budat1 = lwa_data-budat2 = lwa_data-budat3 = lwa_data-budat4 = lwa_data-budat5 = lwa_data-date1  = cl_abap_context_info=>get_system_date( ) .
              CLEAR : lwa_acct,lwa_data2.
              READ TABLE lt_acct INTO lwa_acct WITH KEY PurchaseRequisition = lwa_data-PurchaseRequisition PurchaseRequisitionitem = lwa_data-PurchaseRequisitionitem PurchaseReqnAcctAssgmtNumber = lwa_data-PurchaseReqnAcctAssgmtNumber.
              IF  lwa_acct-MultipleAcctAssgmtDistrPercent IS NOT INITIAL AND sy-subrc IS INITIAL.
                 READ TABLE lt_data2 INTO lwa_data2 WITH KEY PurchaseRequisition = lwa_data-PurchaseRequisition PurchaseRequisitionitem = lwa_data-PurchaseRequisitionitem.
                 IF sy-subrc IS INITIAL AND lwa_data2-RequestedQuantity IS NOT INITIAL.
                    lwa_data-amount = lwa_data2-PurchaseRequisitionPrice * ( lwa_acct-Quantity / lwa_data2-RequestedQuantity ).
                 ENDIF.
              ELSE.
                 READ TABLE lt_data2 INTO lwa_data2 WITH KEY PurchaseRequisition = lwa_data-PurchaseRequisition PurchaseRequisitionitem = lwa_data-PurchaseRequisitionitem.
                 IF sy-subrc IS INITIAL.
                    lwa_data-amount = lwa_data2-PurchaseRequisitionPrice .
                 ENDIF.
              ENDIF.
              "差額處理
              IF lwa_data-amount > l_num_3.
                l_num_3 = lwa_data-amount.
                l_index_2 = l_index.
              ENDIF.
              l_num_2 += lwa_data-amount.
              lwa_data-id = l_id.
              MODIFY lt_data FROM lwa_data INDEX l_index.
            ENDLOOP.
            IF l_num_2 <> lwa_data2-PurchaseRequisitionPrice AND l_num_2 IS NOT INITIAL AND l_index_2 IS NOT INITIAL.
                CLEAR : lwa_data.
                READ TABLE lt_data INTO lwa_data INDEX l_index_2.
                lwa_data-amount += lwa_data2-PurchaseRequisitionPrice - l_num_2.
                MODIFY lt_data FROM lwa_data INDEX l_index_2.
            ENDIF.
        ENDLOOP.
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #(  lt_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
