CLASS zz1_cl_purchaseorder_mes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.

    DATA:
    BEGIN OF wa_PurchaseOrder,
          PurchaseOrder     TYPE I_PurchaseOrderAPI01-PurchaseOrder,
          YY1_PURORDERMES_STATUS_PDH TYPE I_PurchaseOrderAPI01-YY1_PURORDERMES_STATUS_PDH,
          YY1_CONTRACT_NUMBER_PDH TYPE I_PurchaseOrderAPI01-YY1_CONTRACT_NUMBER_PDH,
          YY1_Appoval_PDH TYPE I_PurchaseOrderAPI01-YY1_Appoval_PDH,
        END OF wa_PurchaseOrder.

    METHODS: updateField
      IMPORTING PurchaseOrder LIKE wa_PurchaseOrder.

    METHODS: getEtag
      IMPORTING PurchaseOrder     TYPE I_PurchaseOrderAPI01-PurchaseOrder
      RETURNING VALUE(rv_result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zz1_cl_purchaseorder_mes IMPLEMENTATION.
    METHOD if_apj_dt_exec_object~get_parameters.

        " Return the supported selection parameters here
        et_parameter_def = VALUE #(
            ( selname = 'P_CLNT' kind = if_apj_dt_exec_object=>parameter datatype = 'C' length = 3 param_text =
            '環境' changeable_ind = abap_true )
            ( selname = 'S_DATE' kind = if_apj_dt_exec_object=>select_option datatype = 'D' length = 8 param_text =
            '採購文件日期' changeable_ind = abap_true )
        ).

        " Return the default parameters values here
        et_parameter_val = VALUE #(
          ( selname = 'S_DATE' kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'BT' low = cl_abap_context_info=>get_system_date( )  high = cl_abap_context_info=>get_system_date( ) )
         ).

    ENDMETHOD.


    METHOD if_apj_rt_exec_object~execute.
        "Execution logic when the job is started
        DATA p_clnt TYPE c LENGTH 3.
        DATA: s_date TYPE RANGE OF d,
              a(2).

        DATA: l_password TYPE string ,
              l_name TYPE string.
        DATA: l_url TYPE string.
        DATA: l_body TYPE string.
        DATA: lwa_header TYPE if_web_http_request=>name_value_pair,
               lt_header  TYPE if_web_http_request=>name_value_pairs.
        DATA: l_status TYPE if_web_http_response=>http_status .
        DATA: l_text TYPE string.

        DATA: lr_http_destination TYPE REF TO if_http_destination.
        DATA: lr_web_http_client TYPE REF TO if_web_http_client.
        DATA: lr_request TYPE REF TO if_web_http_request.
        DATA: lr_response TYPE REF TO if_web_http_response.
        DATA: lwa_head TYPE zz1_i_purchaseorder_mes,
              lt_head  TYPE STANDARD TABLE OF zz1_i_purchaseorder_mes,
              lwa_item TYPE zz1_i_purchaseorder_mes,
              lt_item  TYPE STANDARD TABLE OF zz1_i_purchaseorder_mes,
              lwa_component TYPE zz1_i_purchaseorder_mes,
              lt_component  TYPE STANDARD TABLE OF zz1_i_purchaseorder_mes,
              lt_log TYPE STANDARD TABLE OF zz1_purcomes_log,
              l_serialno TYPE zz1_purcomes_log-serial_no ,
              lwa_log TYPE zz1_purcomes_log,
              l_user TYPE zz1_purcomes_log-ernam,
              l_date TYPE zz1_purcomes_log-erdat,
              l_time TYPE zz1_purcomes_log-erfzeit,
              l_check(1).

        DATA:BEGIN OF lwa_PODetails,
              PO(25),
              Item(25),
              PartNO(25),
              PR(25),
              PR_ITEM(25),
              PO_QTY(22),
              UNIT(10),
              Numerator_Conversion(25),
              Denominator_conversion(25),
              FACTORY_NAME(20),
              WAREHOUSE_NO(25),
              del_falg(1),
              Receipt_QTY(22),
              Bounded(25),
              Account_category(1),
              IsReturnsItem(1),
              PurchaseOrderItemCategory(25),
              BillOfMaterialItemNumber,
              Material(40),
              RequiredQuantity(22),
              BaseUnit(25),
              StorageLocation(25),
          END OF lwa_PODetails,
          PODetails LIKE STANDARD TABLE OF lwa_PODetails,

          BEGIN OF  lwa_data,
              PO(25),
              Purchase_group_Code(8),
              Purchase_group_Name(18),
              VENDOR_CODE(16),
              POType(10),
              PO_DATE(8),
              FACTORY_NAME(20),
              Collective_Number(25),
              status(10),
              REMARK(100),
              UPDATE_USERID(22),
              UPDATE_Time(8),
              PODetails LIKE PODetails,
          END OF lwa_data,
          lt_data LIKE STANDARD TABLE OF lwa_data.

        DATA: lwa_PurchaseOrder LIKE wa_PurchaseOrder.
        DATA: lt_text_data TYPE TABLE FOR READ RESULT I_PURCHASEORDERTP_2\\PurchaseOrderNote.
        DATA: lwa_text_data LIKE LINE OF lt_text_data .

        DATA: ls_reported TYPE RESPONSE FOR REPORTED I_PURCHASEORDERTP_2 ,
              ls_failed   TYPE RESPONSE FOR FAILED EARLY I_PURCHASEORDERTP_2.

        DATA: l_err type string..
        DATA: cx_root TYPE REF TO cx_root.
        DATA:l_text2(200).
        " Getting the actual parameter values(Just for show. Not needed for the logic below)
        LOOP AT it_parameters INTO DATA(ls_parameter).
            CASE ls_parameter-selname.
                WHEN 'P_CLNT'.
                    p_clnt = ls_parameter-low.
                WHEN 'S_DATE'.
                    APPEND VALUE #( sign = ls_parameter-sign
                                    option = ls_parameter-option
                                    low = ls_parameter-low
                                    high = ls_parameter-high ) TO s_date.
            ENDCASE.
        ENDLOOP.
        try.
            data(l_log) = cl_bali_log=>create_with_header( cl_bali_header_setter=>create( object =
                           'zz1_purcomes_log' subobject = 'ZZ1_PURCHASEORDERMES' ) ).
        catch cx_bali_runtime.
            "handle exception
            a = 2.
        ENDTRY.

        SELECT * FROM  zz1_i_purchaseorder_mes WHERE PO_DATE IN @s_date
          INTO CORRESPONDING FIELDS OF TABLE @lt_item.
        MOVE-CORRESPONDING lt_item[] TO lt_head[].
        SORT lt_head BY PO.
        DELETE ADJACENT DUPLICATES FROM lt_head COMPARING PO.

*        MOVE-CORRESPONDING lt_item[] TO lt_component[].
*        DELETE lt_component WHERE ( BillOfMaterialItemNumber IS INITIAL OR Material IS INITIAL ).
*        SORT lt_component BY PO Item PurchaseOrderScheduleLine BillOfMaterialItemNumber.

        SORT lt_item BY PO Item.
        DELETE ADJACENT DUPLICATES FROM lt_item COMPARING PO Item.

        IF lt_item IS INITIAL."沒資料
            DATA(l_success_text2) = cl_bali_free_text_setter=>create( severity =
                            if_bali_constants=>C_SEVERITY_STATUS "c_severity_error
                            text = '無可執行之資料' ).
            TRY.
              l_log->add_item( item = l_success_text2 ).
            CATCH cx_bali_runtime.
              a = 2.
            ENDTRY.
        ELSE. "call api
            LOOP AT lt_head INTO lwa_head.
                clear : lwa_data.
                lwa_data-po = lwa_head-po.
                lwa_data-purchase_group_code = lwa_head-Purchase_group_Code.
                lwa_data-purchase_group_name = lwa_head-Purchase_group_Name.
                lwa_data-vendor_code = lwa_head-vendor_code.
                lwa_data-potype      = lwa_head-POType.
                lwa_data-po_date     = lwa_head-po_date.
                lwa_data-status      = lwa_head-status.
                lwa_data-update_userid = lwa_head-update_userid.
                lwa_data-update_time   = sy-uzeit.

                DO 3 TIMES.
                  CLEAR: lwa_text_data, lt_text_data[].
                  READ ENTITIES OF I_PURCHASEORDERTP_2 ENTITY I_PurchaseOrderNoteTP_2
                    FROM VALUE #( ( %key = VALUE #( PurchaseOrder = lwa_data-PO
                                                    TextObjectType = 'F01'
                                                    language         = sy-langu )
                                    %control = VALUE #( PurchaseOrder = if_abap_behv=>mk-on
                                                        TextObjectType = if_abap_behv=>mk-on
                                                        language = if_abap_behv=>mk-on ) ) )
                      RESULT   lt_text_data
                      REPORTED ls_reported
                      FAILED   ls_failed.
                  READ TABLE lt_text_data INTO lwa_text_data INDEX 1.
                  IF lwa_text_data-PlainLongText IS NOT INITIAL.
                    EXIT.
                  ENDIF.
                ENDDO.
                lwa_data-remark = lwa_text_data-PlainLongText.

                CLEAR PODetails[].
                LOOP AT lt_item INTO lwa_item WHERE po = lwa_head-po.
                    CLEAR lwa_PODetails.
                    lwa_PODetails-PO = lwa_item-PO.
                    lwa_PODetails-Item = lwa_item-Item.
                    lwa_PODetails-PartNO = lwa_item-PartNO.
                    lwa_PODetails-PR = lwa_item-PR.
                    lwa_PODetails-PR_ITEM = lwa_item-PR_ITEM.
                    lwa_PODetails-PO_QTY = lwa_item-PO_QTY.
                    lwa_PODetails-UNIT = lwa_item-UNIT.
                    lwa_PODetails-FACTORY_NAME = lwa_item-FACTORY_NAME.
                    lwa_PODetails-WAREHOUSE_NO = lwa_item-WAREHOUSE_NO.
                    lwa_PODetails-del_falg = lwa_item-del_falg.
                    lwa_PODetails-Receipt_QTY = 0.
                    lwa_PODetails-Account_category = lwa_item-Account_category.
                    lwa_PODetails-IsReturnsItem = lwa_item-IsReturnsItem.
                    lwa_PODetails-PurchaseOrderItemCategory = lwa_item-PurchaseOrderItemCategory.
                    IF ( lwa_PODetails-PurchaseOrderItemCategory = 'L' OR lwa_PODetails-PurchaseOrderItemCategory IS INITIAL ).
                        lwa_PODetails-BillOfMaterialItemNumber = lwa_item-BillOfMaterialItemNumber.
                        lwa_PODetails-Material = lwa_item-Material.
                        lwa_PODetails-RequiredQuantity = lwa_item-RequiredQuantity.
                        lwa_PODetails-BaseUnit = lwa_item-BaseUnit.
                        lwa_PODetails-StorageLocation = lwa_item-StorageLocation.
                    ENDIF.
                    APPEND lwa_PODetails TO PODetails.
                ENDLOOP.
                IF PODetails[] IS NOT INITIAL.
                    MOVE-CORRESPONDING PODetails TO lwa_data-PODetails.
                ENDIF.

                "將資料轉成JSON
                l_body = /ui2/cl_json=>serialize( data = lwa_data pretty_name = /ui2/cl_json=>pretty_mode-low_case ).
                FREE: lr_http_destination, lr_web_http_client, lr_request, lr_response.
                TRY.
                    lr_http_destination = cl_http_destination_provider=>create_by_url( i_url = l_url ).
                CATCH cx_http_dest_provider_error INTO DATA(lr_data).
                    a = 2.
                ENDTRY.

                IF lr_data IS INITIAL.
                    TRY.
                        lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).
                    CATCH cx_web_http_client_error INTO DATA(lr_data2).
                        a = 2.
                    ENDTRY.
                    lr_request = lr_web_http_client->get_http_request( ).
                    CLEAR: lwa_header , lt_header.
                    lt_header = "Headers參數
                        VALUE #(
                         ( name = 'Accept' value = 'application/json'  )
                         ( name = 'Content-Type' value = 'application/json'  ) "Content-Type：內容格式(Body的格式)，application/json：JSON格式
                         ( name = 'If-Match' value = '*'  ) ).
                    lr_request->set_authorization_basic( i_username = 'InnatechMIYABI2025TEST' i_password = 'Innatech@MIYABI2025TEST' ).
                    lr_request->set_header_fields( i_fields = lt_header ).
                    lr_request->set_text( i_text = l_body ).
                    lr_web_http_client->set_csrf_token( ). "獲得TOKEN
                    TRY.
                        lr_response = lr_web_http_client->execute( i_method = if_web_http_client=>post ).
                    CATCH cx_web_http_client_error INTO lr_data2.
                        a = 2.
                    ENDTRY.
                    IF lr_response IS BOUND.
                        l_status = lr_response->get_status( ).
                        l_text = lr_response->get_text( ).
                        TRY.
                            lr_web_http_client->close( ).
                        CATCH cx_web_http_client_error INTO lr_data2.
                            a = 2.
                        ENDTRY.
                    ENDIF.
                    CLEAR: lwa_log , l_user, l_date, l_time.
                    lwa_log-po = lwa_data-po.
                    lwa_log-purchase_group_code = lwa_data-purchase_group_code.
                    lwa_log-purchase_group_name = lwa_data-purchase_group_name.
                    lwa_log-vendor_code = lwa_data-vendor_code.
                    lwa_log-potype = lwa_data-potype.
                    lwa_log-po_date = lwa_data-po_date.
                    lwa_log-status = lwa_data-status.
                    lwa_log-remark = lwa_data-remark.
                    lwa_log-update_userid = lwa_data-update_userid.
                    lwa_log-update_time = lwa_data-update_time.
                    l_user = sy-uname.
                    l_date = sy-datum.
                    l_time = sy-uzeit.
                    lwa_log-ernam = l_user.
                    lwa_log-erdat = l_date.
                    lwa_log-erfzeit = l_time.


                    CLEAR lwa_PurchaseOrder.
                    lwa_PurchaseOrder-PurchaseOrder = lwa_data-po.
                    lwa_PurchaseOrder-YY1_CONTRACT_NUMBER_PDH = lwa_head-yy1_contract_number_pdh.
                    lwa_PurchaseOrder-YY1_Appoval_PDH = lwa_head-YY1_Appoval_PDH.

                    IF ( l_status-code = 204 OR l_status-code = 200 ).
                        lwa_log-process_status = 'SUCCESS'.
                        lwa_PurchaseOrder-yy1_purordermes_status_pdh = 'S'.
                        CONCATENATE '已傳送採購單:' lwa_item-po INTO l_text2.
                        l_success_text2 = cl_bali_free_text_setter=>create( severity =
                                if_bali_constants=>C_SEVERITY_STATUS "c_severity_error
                                text = l_text2 ).
                        TRY.
                            l_log->add_item( item = l_success_text2 ).
                        CATCH cx_bali_runtime.
                            a = 2.
                        ENDTRY.
                    ELSE.
                        lwa_log-process_status = 'ERROR'.
                        lwa_PurchaseOrder-yy1_purordermes_status_pdh = 'E'.
                        lwa_log-message = l_text.
                        CONCATENATE '採購單資料傳送失敗:' lwa_item-po INTO l_text2.
                        l_success_text2 = cl_bali_free_text_setter=>create( severity =
                                if_bali_constants=>C_SEVERITY_ERROR "c_severity_error
                                text = l_text2 ).
                        TRY.
                            l_log->add_item( item = l_success_text2 ).
                        CATCH cx_bali_runtime.
                            a = 2.
                        ENDTRY.
                    ENDIF.

                    LOOP AT lt_item INTO lwa_item WHERE po = lwa_head-po.
                        lwa_log-item = lwa_item-Item.
                        lwa_log-billofmaterialitemnumber = lwa_item-BillOfMaterialItemNumber.
                        CLEAR: l_serialno.
                        SELECT SINGLE MAX( serial_no ) FROM zz1_purcomes_log
                            WHERE po = @lwa_log-po AND item = @lwa_log-item
                              AND billofmaterialitemnumber = @lwa_log-billofmaterialitemnumber
                            INTO @l_serialno.
                        lwa_log-serial_no = l_serialno + 1 .
                        lwa_log-partno = lwa_item-partno.
                        lwa_log-pr = lwa_item-pr.
                        lwa_log-pr_item = lwa_item-pr_item.
                        lwa_log-po_qty = lwa_item-po_qty.
                        lwa_log-unit = lwa_item-unit.
                        lwa_log-factory_name = lwa_item-factory_name.
                        lwa_log-warehouse_no = lwa_item-warehouse_no.
                        lwa_log-del_falg = lwa_item-del_falg.
                        lwa_log-receipt_qty = 0.
                        lwa_log-account_category = lwa_item-account_category.
                        lwa_log-isreturnsitem = lwa_item-isreturnsitem.
                        lwa_log-purchaseorderitemcategory = lwa_item-purchaseorderitemcategory.
                        lwa_log-material = lwa_item-material.
                        lwa_log-requiredquantity = lwa_item-requiredquantity.
                        lwa_log-baseunit = lwa_item-baseunit.
                        lwa_log-storagelocation = lwa_item-storagelocation.
                        APPEND lwa_log TO lt_log.
                    ENDLOOP.


                    updateField( PurchaseOrder = lwa_PurchaseOrder ).
               ENDIF.
            ENDLOOP.
            IF lt_log[] IS NOT INITIAL.
                MODIFY zz1_purcomes_log FROM TABLE @lt_log.
            ENDIF.
        ENDIF.
        TRY.
            cl_bali_log_db=>get_instance( )->save_log( log = l_log assign_to_current_appl_job = abap_true ).
        CATCH cx_bali_runtime.
            a = 2.
            "handle exception
        ENDTRY.
        COMMIT WORK.
    ENDMETHOD.

    METHOD updateField.
        DATA: l_url TYPE string.
        DATA: l_body TYPE string.
        DATA: lwa_header TYPE if_web_http_request=>name_value_pair,
              lt_header  TYPE if_web_http_request=>name_value_pairs.
        DATA: l_status TYPE if_web_http_response=>http_status .
        DATA: l_text TYPE string.
        DATA: lr_http_destination TYPE REF TO if_http_destination.
        DATA: lr_web_http_client TYPE REF TO if_web_http_client.
        DATA: lr_request TYPE REF TO if_web_http_request.
        DATA: lr_response TYPE REF TO if_web_http_response.

        CLEAR: lt_header, l_body, l_url.

        DATA(l_etag) = getEtag( PurchaseOrder = PurchaseOrder-PurchaseOrder ).
        IF l_etag IS INITIAL.
            lt_header = "Headers參數
                VALUE #(
                 ( name = 'Accept' value = 'application/json'  )
                 ( name = 'Content-Type' value = 'application/json'  ) "Content-Type：內容格式(Body的格式)，application/json：JSON格式
                 ( name = 'If-Match' value = '*'  ) ).
        ELSE.
            lt_header = "Headers參數
                VALUE #(
                 ( name = 'Accept' value = 'application/json'  )
                 ( name = 'Content-Type' value = 'application/json'  ) "Content-Type：內容格式(Body的格式)，application/json：JSON格式
                 ( name = 'If-Match' value = l_etag  ) ).
        ENDIF.

        l_body = `{"d":{"YY1_PURORDERMES_STATUS_PDH":"` && PurchaseOrder-yy1_purordermes_status_pdh.
        l_body = l_body && `", "YY1_CONTRACT_NUMBER_PDH":"` && PurchaseOrder-YY1_CONTRACT_NUMBER_PDH.
        l_body = l_body && `", "YY1_Appoval_PDH ":"` && PurchaseOrder-YY1_Appoval_PDH  && `"}}`.

        l_url = `https://my427098-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV/A_PurchaseOrder('` &&  PurchaseOrder-purchaseorder && `')`.

        CLEAR: l_status, l_text.
        FREE: lr_http_destination, lr_web_http_client, lr_request, lr_response.
        TRY.
            lr_http_destination = cl_http_destination_provider=>create_by_url( i_url = l_url ). "直接在程式碼中指定 URL 來呼叫 HTTP 或 SOAP 服務
        CATCH cx_http_dest_provider_error INTO DATA(lr_data).
        ENDTRY.
        IF lr_data IS INITIAL.
            TRY.
                lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).

                lr_request = lr_web_http_client->get_http_request( ).
                lr_request->set_authorization_basic( i_username = 'InnatechMIYABI2025TEST' i_password = 'Innatech@MIYABI2025TEST' ).
                lr_request->set_header_fields( i_fields = lt_header ).
                lr_request->set_text( i_text = l_body ).
                lr_web_http_client->set_csrf_token( ). "獲得TOKEN
                lr_response = lr_web_http_client->execute( i_method
                = if_web_http_client=>PATCH ).
                IF lr_response IS BOUND.
                    l_status = lr_response->get_status( ). "獲得執行結果狀態
                    l_text = lr_response->get_text( ). "獲得執行結果訊息
                ENDIF.
                DATA(lr_web_http_response) = lr_web_http_client->execute( if_web_http_client=>PATCH ).
                DATA(l_response) = lr_web_http_response->get_text( ).
                lr_web_http_client->close( ).
            CATCH cx_web_http_client_error INTO DATA(lr_data2).
            ENDTRY.
            IF ( l_status-code = 204 OR l_status-code = 200 ).

            ENDIF.
       ENDIF.
    ENDMETHOD.

    METHOD getEtag.
        DATA: l_url TYPE string.
        DATA: l_etag  TYPE string.
        DATA: lwa_header TYPE if_web_http_request=>name_value_pair,
              lt_header  TYPE if_web_http_request=>name_value_pairs.
        DATA: l_status TYPE if_web_http_response=>http_status .
        DATA: l_text TYPE string.
        DATA: lr_http_destination TYPE REF TO if_http_destination.
        DATA: lr_web_http_client TYPE REF TO if_web_http_client.
        DATA: lr_request TYPE REF TO if_web_http_request.
        DATA: lr_response TYPE REF TO if_web_http_response.

        CLEAR: lt_header, l_url.
        lt_header = "Headers參數
            VALUE #(
             ( name = 'Accept' value = 'application/json'  )
             ( name = 'Content-Type' value = 'application/json'  ) "Content-Type：內容格式(Body的格式)，application/json：JSON格式
             ( name = 'If-Match' value = '*'  ) ).

        l_url = `https://my427098-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEORDER_PROCESS_SRV/A_PurchaseOrder('` &&  PurchaseOrder && `')`.

        CLEAR: l_status, l_text.
        FREE: lr_http_destination, lr_web_http_client, lr_request, lr_response.
        TRY.
            lr_http_destination = cl_http_destination_provider=>create_by_url( i_url = l_url ). "直接在程式碼中指定 URL 來呼叫 HTTP 或 SOAP 服務
        CATCH cx_http_dest_provider_error INTO DATA(lr_data).
        ENDTRY.
        IF lr_data IS INITIAL.
            TRY.
                lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).

                lr_request = lr_web_http_client->get_http_request( ).
                lr_request->set_authorization_basic( i_username = 'InnatechMIYABI2025TEST' i_password = 'Innatech@MIYABI2025TEST' ).
                lr_request->set_header_fields( i_fields = lt_header ).
                lr_web_http_client->set_csrf_token( ). "獲得TOKEN
                lr_response = lr_web_http_client->execute( i_method
                = if_web_http_client=>GET ).
                IF lr_response IS BOUND.
                    l_status = lr_response->get_status( ). "獲得執行結果狀態
                    l_text = lr_response->get_text( ). "獲得執行結果訊息
                ENDIF.
                DATA(lr_web_http_response) = lr_web_http_client->execute( if_web_http_client=>GET ).
                DATA(l_response) = lr_web_http_response->get_text( ).

                rv_result = lr_response->get_header_field( 'ETag' ).  " ← 拿到 ETag
                lr_web_http_client->close( ).
            CATCH cx_web_http_client_error INTO DATA(lr_data2).
            ENDTRY.
            IF ( l_status-code = 204 OR l_status-code = 200 ).

            ENDIF.
       ENDIF.

    ENDMETHOD.

    METHOD if_oo_adt_classrun~main.
    ENDMETHOD.
ENDCLASS.
