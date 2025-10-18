*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_zz1_i_prexportiv DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    DATA t_del TYPE TABLE FOR UPDATE zz1_i_prexportiv_d.
    DATA wa_del LIKE LINE OF t_del.
    DATA t_del2 TYPE STANDARD TABLE OF zz1_i_prexportiv_d.
    DATA: ls_so_temp_key TYPE STRUCTURE FOR KEY OF i_salesordertp.
    DATA:w_check(1).
    DATA: l_pass       TYPE string VALUE 'GQZLeVGhrHsTTmf{uhTialfknlcXhnEs4fDittKQ',
          w_clientd(3) VALUE 'N8M',
          w_clientt(3) VALUE 'N8X',
          w_clientp(3) VALUE 'PHK'.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zz1_i_prexportiv_d RESULT result.
    METHODS create_iv FOR DETERMINE ON SAVE
      IMPORTING keys FOR zz1_i_prexportiv_d~create_iv.
*      CHANGING reported TYPE data.
ENDCLASS.
CLASS lhc_zz1_i_prexportiv IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD create_iv.
    DATA: l_headurl TYPE string .
    DATA: l_patchurl TYPE string .

    DATA: l_password TYPE string,
          l_name     TYPE string.
    IF  sy-sysid = w_clientd.
      l_headurl = `https://my417265-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
      l_patchurl = `https://my417265-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
    ELSEIF sy-sysid = w_clientt.
      l_headurl = `https://my417295-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
      l_patchurl = `https://my417295-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
    ELSEIF sy-sysid = w_clientp.
*        l_headurl = `https://my410597-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
*        l_patchurl = `https://my410597-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
    ENDIF.
    DATA: l_auth(500).
    DATA: l_body TYPE string.
    DATA: lr_http_destination TYPE REF TO if_http_destination.
    DATA: lr_web_http_client TYPE REF TO if_web_http_client.
    DATA: lr_request TYPE REF TO if_web_http_request.
    DATA: lr_response TYPE REF TO if_web_http_response.

    DATA: BEGIN OF lwa_message,
            lang(100),
            value(200),
          END OF lwa_message.
    DATA: BEGIN OF lwa_code,
            code(70),
            message  LIKE lwa_message,
          END OF lwa_code.
*    DATA: BEGIN OF lwa_res, "RESPONSE DATA
*            BEGIN OF error,
*             code(70),
*             message LIKE lwa_message,
*            END OF error,
*      END OF lwa_res.
    DATA: l_url TYPE string.
    DATA: lwa_header TYPE if_web_http_request=>name_value_pair,
          lt_header  TYPE if_web_http_request=>name_value_pairs.
    DATA: l_status TYPE if_web_http_response=>http_status .
    DATA: l_text TYPE string.
    DATA :a TYPE c LENGTH 1.
    DATA: lt_del      TYPE STANDARD TABLE OF zz1_i_prexportiv_d,
          lwa_del     TYPE zz1_i_prexportiv_d,
          lt_result2  TYPE TABLE OF zz1_i_prexportiv_d,
          lwa_result2 TYPE  zz1_i_prexportiv_d,
          l_kpein     TYPE p LENGTH 5 DECIMALS 0 VALUE 1.

    DATA : BEGIN OF lwa_glacct,
             supplierinvoiceitem(2),
             companycode(4),
             glaccount(10),
             supplierinvoiceitemtext(50),
             debitcreditcode(1),
             documentcurrency(5),
             supplierinvoiceitemamount(50),
             taxcode(2),
             taxjurisdiction(15),
             assignmentreference(18),
             costcenter(10),
             profitcenter(10),
             internalorder(12),
             wbselement(24),
             businessarea(4),
             businessprocess(12),
             controllingarea(4),
             costctractivitytype(6),
             costobject(12),
             functionalarea(16),
             isnotcashdiscountliable       TYPE abap_bool,
             personnelnumber(8),
             salesorder(10),
             salesorderitem(6),
             projectnetwork(12),
             networkactivity(4),
             workitem(10),
             commitmentitem(14),
             fundscenter(16),
             taxbaseamountintranscrcy(50),
             fund(10),
             grantid(20),
             quantityunit(30),
             quantity(50),
             partnerbusinessarea(4),
             servicedocumenttype(4),
             servicedocument(10),
             servicedocumentitem(6),
             taxcountry(3),
             financialtransactiontype(3),
             budgetperiod(10),
             earmarkedfundsdocument(10),
             earmarkedfundsdocumentitem(3),
*           EMRKDFNDSITMISCOMPLETED(1),
*           JOINTVENTURERECOVERYCODE(2) ,
           END OF lwa_glacct.

    DATA : BEGIN OF lwa_data,
             companycode2(4),
             documentdate(30),
             postingdate(30),
*         SupplierInvoiceTransactionType(1),
             supplierinvoiceidbyinvcgparty(16),
             invoicingparty(10),
             documentcurrency(5),
             invoicegrossamount(50),
             documentheadertext(25),
             paymentterms(4),
             accountingdocumenttype(2),
             taxiscalculatedautomatically       TYPE abap_bool VALUE abap_true,
             businessplace(4),
             paymentblockingreason(1),
             duecalculationbasedate(30),
             manualcashdiscount(50),
             paymentmethod(1),
             paymentmethodsupplement(2),
             paymentreference(30),
             invoicereference(10),
             invoicereferencefiscalyear(4),
             cashdiscount1days(3),
             cashdiscount1percent(5),
             cashdiscount2days(3),
             cashdiscount2percent(5),
             netpaymentdays(3),
             fixedcashdiscount(1),
             unplanneddeliverycost(50),
             unplanneddeliverycosttaxcode(2),
             unplnddelivcosttaxjurisdiction(15),
*         REFERENCEDOCUMENTCATEGORY(1),
             assignmentreference(18),
             supplierpostinglineitemtext(50),
             businesssectioncode(4),
             paytslipwthrefsubscriber(11),
             paytslipwthrefcheckdigit(2),
             paytslipwthrefreference(27),
             businessarea(4),
             invoicereceiptdate(30),
             deliveryofgoodsreportingcntry(3),
             iseutriangulardeal                 TYPE abap_bool,
             taxdeterminationdate(30),
             housebank(5),
             housebankaccount(5),
             unplnddeliverycosttaxcountry(3),
             jrnlentrycntryspecificref1(80),
             jrnlentrycntryspecificdate1(30),
             bpbankaccountinternalid(4),
             taxreportingdate(30),
             taxfulfillmentdate(30),
             jrnlentrycntryspecificbp1(10),
             jrnlentrycntryspecificbp2(10),
             jrnlentrycntryspecificdate2(30),
             jrnlentrycntryspecificdate3(30),
             jrnlentrycntryspecificdate4(30),
             jrnlentrycntryspecificdate5(30),
             jrnlentrycntryspecificref2(25),
             jrnlentrycntryspecificref3(25),
             jrnlentrycntryspecificref4(50),
             jrnlentrycntryspecificref5(50),
             paymentreason(4),
             supplierinvoicestatus(1)           VALUE '',
             supplierinvoiceiscreditmemo(1),
             to_supplierinvoiceitemglacct       LIKE STANDARD TABLE OF lwa_glacct,
           END OF lwa_data.
* DATA: BEGIN OF lwa_data_res,
*            d LIKE STANDARD TABLE OF lwa_data,
**            d LIKE  lwa_data,
*       END OF lwa_data_res.

    DATA lt_prexport TYPE TABLE FOR UPDATE zz1_i_prexportiv_d.
    DATA lwa_prexport TYPE STRUCTURE FOR UPDATE zz1_i_prexportiv_d.
    DATA : lwa_data_hd LIKE lwa_data,
           lt_data_hd  LIKE STANDARD TABLE OF lwa_data.
    DATA : l_num TYPE i.
    DATA : BEGIN OF lwa_text,
             supplierinvoiceitemtext LIKE lwa_glacct-supplierinvoiceitemtext,
           END OF lwa_text,
           lt_text LIKE STANDARD TABLE OF lwa_text.
    DATA : l_vbeln(10),
           l_posnr(5),
           BEGIN OF wa_data4,
             value TYPE c LENGTH 500,
           END OF wa_data4,
           BEGIN OF wa_data3,
             code    TYPE c LENGTH 500,
             message LIKE wa_data4,
           END OF wa_data3,
           BEGIN OF lwa_res_err,
             error LIKE wa_data3,
           END OF lwa_res_err,
           BEGIN OF wa_data5,
             code(500),
             message(500),
           END OF wa_data5,
           BEGIN OF lwa_res_err2,
             error LIKE wa_data5,
           END OF lwa_res_err2,
           BEGIN OF lwa_res,
             BEGIN OF d,
               BEGIN OF __metadata,
                 id(500),
                 uri(500),
                 type(500),
               END OF __metadata,
               supplierinvoice(10),
               fiscalyear(4),
               companycode(4),
               documentdate(30),
               postingdate(30),
             END OF d,
           END OF lwa_res.
    DATA: lwa_bseg TYPE i_journalentryitem,
          lt_bseg  TYPE STANDARD TABLE OF i_journalentryitem,
          lwa_bkpf TYPE i_journalentryitem.

    DATA: lwa_je TYPE STRUCTURE FOR ACTION IMPORT i_journalentrytp\\journalentry~change,
          lt_je  TYPE TABLE FOR ACTION IMPORT i_journalentrytp\\journalentry~change.

    DATA: lwa_item TYPE STRUCTURE FOR HIERARCHY d_journalentrychangeglitemp,
          lt_item  TYPE TABLE FOR HIERARCHY d_journalentrychangeglitemp.
*    SELECT * FROM ZZ1_I_PREXPORTIV_D WHERE companycode2 IS NOT INITIAL INTO CORRESPONDING FIELDS OF TABLE @lt_del."
*    MODIFY ENTITIES OF ZZ1_I_PREXPORTIV_D IN LOCAL MODE
*    ENTITY ZZ1_I_PREXPORTIV_D DELETE FROM VALUE #( ( iv_uuid = space  ) ).
*    LOOP AT lt_del INTO lwa_del.
*      MODIFY ENTITIES OF ZZ1_I_PREXPORTIV_D IN LOCAL MODE
*      ENTITY ZZ1_I_PREXPORTIV_D DELETE FROM VALUE #( ( iv_uuid = lwa_del-iv_uuid ) ).
*    ENDLOOP.
    "讀取EXCEL資料
    READ ENTITIES OF zz1_i_prexportiv_d IN LOCAL MODE
        ENTITY zz1_i_prexportiv_d
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_result)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).
    SORT lt_result BY id ASCENDING .
    DATA: lwa_result LIKE LINE OF lt_result .
    DATA: l_number(4).
    CLEAR: reported.
    CLEAR w_check .
    LOOP AT lt_result INTO lwa_result.
      CLEAR : lt_del.
      SELECT iv_uuid FROM zz1_i_prexportiv_d WHERE purchaserequisition = @lwa_result-purchaserequisition AND purchaserequisitionitem = @lwa_result-purchaserequisitionitem  " IS INITIAL
       INTO CORRESPONDING FIELDS OF TABLE @lt_del.
      LOOP AT lt_del INTO lwa_del.
        MODIFY ENTITIES OF zz1_i_prexportiv_d IN LOCAL MODE
        ENTITY zz1_i_prexportiv_d DELETE FROM VALUE #( (  iv_uuid = lwa_del-iv_uuid ) ).
      ENDLOOP.

    ENDLOOP.
    MOVE-CORRESPONDING lt_result[] TO lt_result2[].
    DELETE ADJACENT DUPLICATES FROM lt_result2 COMPARING id.
    LOOP AT lt_result2 INTO lwa_result2.
*        CLEAR : lwa_del.
*        SELECT SINGLE iv_uuid FROM ZZ1_I_PREXPORTIV_D WHERE purchaserequisition = @lwa_result2-purchaserequisition AND purchaserequisitionitem = @lwa_result2-purchaserequisitionitem  " IS INITIAL
*         INTO CORRESPONDING FIELDS OF @lwa_del.
*        MODIFY ENTITIES OF ZZ1_I_PREXPORTIV_D IN LOCAL MODE
*        ENTITY ZZ1_I_PREXPORTIV_D DELETE FROM VALUE #( (  iv_uuid = lwa_del-iv_uuid ) )
*        .

      CLEAR : lwa_data , l_num,lt_text,lwa_prexport.
      lwa_prexport = CORRESPONDING #( lwa_result2 ).
      lwa_data-companycode2 = lwa_result2-companycode.
*        lwa_data-supplierinvoicetransactiontype = lwa_result-supplierinvoicetransactiontype.
      lwa_data-invoicingparty = lwa_result2-invoicingparty.
      lwa_data-supplierinvoiceidbyinvcgparty = lwa_result2-supplierinvoiceidbyinvcgparty.
*        lwa_data-documentdate = lwa_result-documentdate.
      CONCATENATE lwa_result2-documentdate(4) '-' lwa_result2-documentdate+4(2) '-' lwa_result2-documentdate+6(2) 'T09:00:00' INTO lwa_data-documentdate.
*        lwa_data-postingdate = lwa_result-postingdate.
      CONCATENATE lwa_result2-postingdate(4) '-' lwa_result2-postingdate+4(2) '-' lwa_result2-postingdate+6(2) 'T09:00:00' INTO lwa_data-postingdate.
      lwa_data-accountingdocumenttype = lwa_result2-accountingdocumenttype.
      lwa_data-documentcurrency = lwa_result2-documentcurrency.
      lwa_data-invoicegrossamount = lwa_result2-invoicegrossamount.
      CONDENSE lwa_data-invoicegrossamount.
      lwa_data-documentheadertext = lwa_result2-accountingdocumentheadertext.
      lwa_data-businessplace = lwa_result2-businessplace.
      lwa_data-paymentblockingreason = lwa_result2-paymentblockingreason.
*        lwa_data-duecalculationbasedate = lwa_result-duecalculationbasedate.
      IF lwa_result2-duecalculationbasedate IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01'  'T09:00:00' INTO lwa_data-duecalculationbasedate.
      ELSE.
        CONCATENATE lwa_result2-duecalculationbasedate(4) '-' lwa_result2-duecalculationbasedate+4(2) '-' lwa_result2-duecalculationbasedate+6(2) 'T00:00:00' INTO lwa_data-duecalculationbasedate.
      ENDIF.
      lwa_data-manualcashdiscount = lwa_result2-manualcashdiscount.
      CONDENSE lwa_data-manualcashdiscount.
      lwa_data-paymentmethod = lwa_result2-paymentmethod.
      lwa_data-paymentmethodsupplement = lwa_result2-paymentmethodsupplement.
      lwa_data-paymentreference = lwa_result2-paymentreference.
      lwa_data-invoicereference = lwa_result2-invoicereference.
      lwa_data-invoicereferencefiscalyear = lwa_result2-invoicereferencefiscalyear.
      lwa_data-paymentterms = lwa_result2-paymentterms.
      IF lwa_result2-cashdiscount1days IS NOT INITIAL.
        lwa_data-cashdiscount1days = lwa_result2-cashdiscount1days.
      ELSE.
        lwa_data-cashdiscount1days = 0.
      ENDIF.
      CONDENSE lwa_data-cashdiscount1days.
      IF lwa_result2-cashdiscount1percent IS NOT INITIAL.
        lwa_data-cashdiscount1percent = lwa_result2-cashdiscount1percent.
      ELSE.
        lwa_data-cashdiscount1percent = 0.
      ENDIF.
      CONDENSE lwa_data-cashdiscount1percent.
      IF lwa_result2-cashdiscount2days IS NOT INITIAL.
        lwa_data-cashdiscount2days = lwa_result2-cashdiscount2days.
      ELSE.
        lwa_data-cashdiscount2days = 0.
      ENDIF.
      CONDENSE lwa_data-cashdiscount2days.
      IF lwa_result2-cashdiscount2percent IS NOT INITIAL.
        lwa_data-cashdiscount2percent = lwa_result2-cashdiscount2percent.
      ELSE.
        lwa_data-cashdiscount2percent = 0.
      ENDIF.
      CONDENSE lwa_data-cashdiscount2percent.
      IF lwa_result2-netpaymentdays IS NOT INITIAL.
        lwa_data-netpaymentdays = lwa_result2-netpaymentdays.
      ELSE.
        lwa_data-netpaymentdays = 0.
      ENDIF.
      CONDENSE lwa_data-netpaymentdays.
      lwa_data-fixedcashdiscount = lwa_result2-fixedcashdiscount.
      IF lwa_result2-unplanneddeliverycost IS NOT INITIAL.
        lwa_data-unplanneddeliverycost = lwa_result2-unplanneddeliverycost.
      ELSE.
        lwa_data-unplanneddeliverycost = 0.
      ENDIF.
      CONDENSE lwa_data-unplanneddeliverycost.
      lwa_data-unplanneddeliverycosttaxcode = lwa_result2-unplanneddeliverycosttaxcode.
      lwa_data-unplnddelivcosttaxjurisdiction = lwa_result2-unplnddelivcosttaxjurisdiction.
*        lwa_data-referencedocumentcategory = lwa_result-referencedocumentcategory.
      lwa_data-assignmentreference = lwa_result2-assignmentreference.
      lwa_data-supplierpostinglineitemtext = lwa_result2-supplierpostinglineitemtext.
      lwa_data-businesssectioncode = lwa_result2-businesssectioncode.
      lwa_data-paytslipwthrefsubscriber = lwa_result2-paytslipwthrefsubscriber.
      lwa_data-paytslipwthrefcheckdigit = lwa_result2-paytslipwthrefcheckdigit.
      lwa_data-paytslipwthrefreference = lwa_result2-paytslipwthrefreference.
      lwa_data-businessarea = lwa_result2-businessarea.
      lwa_data-taxiscalculatedautomatically = abap_true.
*        lwa_data-invoicereceiptdate =  lwa_result-invoicereceiptdate.
      CONCATENATE lwa_result2-invoicereceiptdate(4) '-' lwa_result2-invoicereceiptdate+4(2) '-' lwa_result2-invoicereceiptdate+6(2) 'T09:00:00' INTO lwa_data-invoicereceiptdate.
      lwa_data-deliveryofgoodsreportingcntry = lwa_result2-deliveryofgoodsreportingcntry.
      lwa_data-iseutriangulardeal = abap_false.
*        lwa_data-taxdeterminationdate = lwa_result-taxdeterminationdate.
      CONCATENATE lwa_result2-taxdeterminationdate(4) '-' lwa_result2-taxdeterminationdate+4(2) '-' lwa_result2-taxdeterminationdate+6(2) 'T09:00:00' INTO lwa_data-taxdeterminationdate.
      lwa_data-housebank = lwa_result2-housebank.
      lwa_data-housebankaccount = lwa_result2-housebankaccount.
      lwa_data-unplnddeliverycosttaxcountry = lwa_result2-unplnddeliverycosttaxcountry.
      lwa_data-jrnlentrycntryspecificref1 = lwa_result2-jrnlentrycntryspecificref1.
      lwa_data-jrnlentrycntryspecificdate1 = lwa_result2-jrnlentrycntryspecificdate1.
      IF lwa_result2-jrnlentrycntryspecificdate1 IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01' 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate1.
      ELSE.
        CONCATENATE lwa_result2-jrnlentrycntryspecificdate1(4) '-' lwa_result2-jrnlentrycntryspecificdate1+4(2) '-' lwa_result2-jrnlentrycntryspecificdate1+6(2) 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate1.
      ENDIF.
      lwa_data-bpbankaccountinternalid = lwa_result-bpbankaccountinternalid.
*        lwa_data-taxreportingdate = lwa_result-taxreportingdate.
      CONCATENATE lwa_result2-taxreportingdate(4) '-' lwa_result2-taxreportingdate+4(2) '-' lwa_result2-taxreportingdate+6(2) 'T09:00:00' INTO lwa_data-taxreportingdate.
*        lwa_data-taxfulfillmentdate = lwa_result-taxfulfillmentdate.
      CONCATENATE lwa_result2-taxfulfillmentdate(4) '-' lwa_result2-taxfulfillmentdate+4(2) '-' lwa_result2-taxfulfillmentdate+6(2) 'T09:00:00' INTO lwa_data-taxfulfillmentdate.
      lwa_data-jrnlentrycntryspecificbp1 = lwa_result2-jrnlentrycntryspecificbp1.
      lwa_data-jrnlentrycntryspecificbp2 = lwa_result2-jrnlentrycntryspecificbp2.
      lwa_data-jrnlentrycntryspecificdate2 = lwa_result2-jrnlentrycntryspecificdate2.
      IF lwa_result2-jrnlentrycntryspecificdate2 IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01' 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate2.
      ELSE.
        CONCATENATE lwa_result2-jrnlentrycntryspecificdate2(4) '-' lwa_result2-jrnlentrycntryspecificdate2+4(2) '-' lwa_result2-jrnlentrycntryspecificdate2+6(2) 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate2.
      ENDIF.
      lwa_data-jrnlentrycntryspecificdate3 = lwa_result2-jrnlentrycntryspecificdate3.
      IF lwa_result2-jrnlentrycntryspecificdate3 IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01' 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate3.
      ELSE.
        CONCATENATE lwa_result2-jrnlentrycntryspecificdate3(4) '-' lwa_result2-jrnlentrycntryspecificdate3+4(2) '-' lwa_result2-jrnlentrycntryspecificdate3+6(2) 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate3.
      ENDIF.
      lwa_data-jrnlentrycntryspecificdate4 = lwa_result2-jrnlentrycntryspecificdate4.
      IF lwa_result2-jrnlentrycntryspecificdate4 IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01' 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate4.
      ELSE.
        CONCATENATE lwa_result2-jrnlentrycntryspecificdate4(4) '-' lwa_result2-jrnlentrycntryspecificdate4+4(2) '-' lwa_result2-jrnlentrycntryspecificdate4+6(2) 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate4.
      ENDIF.
      lwa_data-jrnlentrycntryspecificdate5 = lwa_result2-jrnlentrycntryspecificdate5.
      IF lwa_result2-jrnlentrycntryspecificdate5 IS INITIAL.
        CONCATENATE '1900' '-' '01' '-' '01' 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate5.
      ELSE.
        CONCATENATE lwa_result2-jrnlentrycntryspecificdate5(4) '-' lwa_result2-jrnlentrycntryspecificdate5+4(2) '-' lwa_result2-jrnlentrycntryspecificdate5+6(2) 'T09:00:00' INTO lwa_data-jrnlentrycntryspecificdate5.
      ENDIF.
      lwa_data-jrnlentrycntryspecificref2 = lwa_result2-jrnlentrycntryspecificref2.
      lwa_data-jrnlentrycntryspecificref3 = lwa_result2-jrnlentrycntryspecificref3.
      lwa_data-jrnlentrycntryspecificref4 = lwa_result2-jrnlentrycntryspecificref4.
      lwa_data-jrnlentrycntryspecificref5 = lwa_result2-jrnlentrycntryspecificref5.
      lwa_data-paymentreason = lwa_result2-paymentreason.
      lwa_data-supplierinvoicestatus = ''.
      IF lwa_result2-debitcreditcode = 'H'.
        lwa_data-supplierinvoiceiscreditmemo = 'X'.
      ELSEIF lwa_result2-debitcreditcode = 'S'.
        lwa_data-supplierinvoiceiscreditmemo = ''.
      ENDIF.
      LOOP AT lt_result INTO lwa_result WHERE id = lwa_result2-id.
        CLEAR : lwa_glacct,lwa_text.
        lwa_prexport = CORRESPONDING #( lwa_result ).
        l_num += 1.
        lwa_glacct-supplierinvoiceitem = l_num.
        lwa_glacct-companycode = lwa_result-companycode.
        lwa_glacct-glaccount = lwa_result-glaccount.
        lwa_glacct-supplierinvoiceitemtext = lwa_result-supplierinvoiceitemtext.
        lwa_glacct-debitcreditcode = lwa_result-debitcreditcode.
        lwa_glacct-documentcurrency = lwa_result-documentcurrency.
        IF lwa_result-supplierinvoiceitemamount IS NOT INITIAL.
          lwa_glacct-supplierinvoiceitemamount = lwa_result-supplierinvoiceitemamount.
        ELSE.
          lwa_glacct-supplierinvoiceitemamount = 0.
        ENDIF.
        CONDENSE lwa_glacct-supplierinvoiceitemamount.
        lwa_glacct-taxcode = lwa_result-taxcode.
        lwa_glacct-taxjurisdiction = lwa_result-taxjurisdiction.
        lwa_glacct-assignmentreference = lwa_result-assignmentreference.
        lwa_glacct-costcenter = lwa_result-costcenter.
        lwa_glacct-profitcenter = lwa_result-profitcenter.
        lwa_glacct-internalorder = lwa_result-internalorder.
        lwa_glacct-wbselement = lwa_result-wbselement.
        lwa_glacct-businessarea = lwa_result-businessarea.
        lwa_glacct-businessprocess = lwa_result-businessprocess.
        lwa_glacct-controllingarea = lwa_result-controllingarea.
        lwa_glacct-costctractivitytype = lwa_result-costctractivitytype.
        lwa_glacct-costobject = lwa_result-costobject.
        lwa_glacct-functionalarea = lwa_result-functionalarea.
        IF lwa_result-isnotcashdiscountliable IS NOT INITIAL .
          lwa_glacct-isnotcashdiscountliable = abap_true.
        ELSE.
          lwa_glacct-isnotcashdiscountliable = abap_false.
        ENDIF..
        lwa_glacct-personnelnumber = lwa_result-personnelnumber.
        lwa_glacct-salesorder = lwa_result-salesorder.
        lwa_glacct-salesorderitem = lwa_result-salesorderitem.
        lwa_glacct-projectnetwork = lwa_result-projectnetwork.
        lwa_glacct-networkactivity = lwa_result-networkactivity.
        lwa_glacct-workitem = lwa_result-workitem.
        lwa_glacct-commitmentitem = lwa_result-commitmentitem.
        lwa_glacct-fundscenter = lwa_result-fundsmanagementcenter.
        IF lwa_result-taxbaseamountintranscrcy IS NOT INITIAL.
          lwa_glacct-taxbaseamountintranscrcy = lwa_result-taxbaseamountintranscrcy.
        ELSE.
          lwa_glacct-taxbaseamountintranscrcy = 0.
        ENDIF.
        CONDENSE lwa_glacct-taxbaseamountintranscrcy.
        lwa_glacct-fund = lwa_result-funds.
*            lwa_glacct-grantid = lwa_result-grant.
        lwa_glacct-quantityunit = lwa_result-quantityunit.
        IF lwa_result-quantity IS NOT INITIAL.
          lwa_glacct-quantity = lwa_result-quantity.
        ELSE.
          lwa_glacct-quantity = 0.
        ENDIF.
        CONDENSE lwa_glacct-quantity.
        lwa_glacct-partnerbusinessarea = lwa_result-partnerbusinessarea.
        lwa_glacct-servicedocumenttype = lwa_result-servicedocumenttype.
        lwa_glacct-servicedocument = lwa_result-servicedocument.
        lwa_glacct-servicedocumentitem = lwa_result-servicedocumentitem.
        lwa_glacct-taxcountry = lwa_result-taxcountry.
        lwa_glacct-financialtransactiontype = lwa_result-financialtransactiontype.
        lwa_glacct-budgetperiod = lwa_result-budgetperiod.
        lwa_glacct-earmarkedfundsdocument = lwa_result-earmarkedfundsdocument.
        lwa_glacct-earmarkedfundsdocumentitem = lwa_result-earmarkedfundsdocumentitem.
*            lwa_glacct-emrkdfndsitmiscompleted = lwa_result-emrkdfndsitmiscompleted.
*            lwa_glacct-jointventurerecoverycode = lwa_result-jointventurerecoverycode.
        APPEND lwa_glacct TO lwa_data-to_supplierinvoiceitemglacct.
*            lwa_text-supplierinvoiceitemtext = lwa_result-supplierinvoiceitemtext.
*            APPEND lwa_text TO lt_text.
        lwa_prexport-purchaserequisition = lwa_result-purchaserequisition.
        lwa_prexport-purchaserequisitionitem = lwa_result-purchaserequisitionitem.
        APPEND lwa_prexport TO lt_prexport.
*            APPEND lwa_data TO lwa_data_res-d.
      ENDLOOP.
      "CALL API
      CLEAR:  l_body, lt_header.
      lt_header =
         VALUE #(
           ( name = 'Accept' value = 'application/json'  )
           ( name = 'Content-Type' value = 'application/json'  )
*                 ( name = 'If-Match' value = '*'  )
           ).
      l_body = /ui2/cl_json=>serialize( data = lwa_data pretty_name = /ui2/cl_json=>pretty_mode-low_case ).
      REPLACE ALL OCCURRENCES OF:
          'earmarkedfundsdocumentitem' IN l_body WITH 'EarmarkedFundsDocumentItem'.
      REPLACE ALL OCCURRENCES OF:
          'earmarkedfundsdocument' IN l_body WITH 'EarmarkedFundsDocument'.
      REPLACE ALL OCCURRENCES OF:
          'servicedocumentitem' IN l_body WITH 'ServiceDocumentItem'.
      REPLACE ALL OCCURRENCES OF:
          'partnerbusinessarea' IN l_body WITH 'PartnerBusinessArea'.
      REPLACE ALL OCCURRENCES OF:
          'salesorderitem' IN l_body WITH 'SalesOrderItem'.
      REPLACE ALL OCCURRENCES OF:
          'unplnddelivcosttaxjurisdiction' IN l_body WITH 'UnplndDelivCostTaxJurisdiction'.
      REPLACE ALL OCCURRENCES OF:
          'invoicereferencefiscalyear' IN l_body WITH 'InvoiceReferenceFiscalYear'.
      REPLACE ALL OCCURRENCES OF:
          'cashdiscount2percent' IN l_body WITH 'CashDiscount2Percent'.
      REPLACE ALL OCCURRENCES OF:
          'housebankaccount' IN l_body WITH 'HouseBankAccount'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoiceitemtext' IN l_body WITH 'SupplierInvoiceItemText'.
      REPLACE ALL OCCURRENCES OF:
          'taxcode' IN l_body WITH 'TaxCode'.
      REPLACE ALL OCCURRENCES OF:
          'taxjurisdiction' IN l_body WITH 'TaxJurisdiction'.
      REPLACE ALL OCCURRENCES OF:
          'assignmentreference' IN l_body WITH 'AssignmentReference'.
      REPLACE ALL OCCURRENCES OF:
          'costcenter' IN l_body WITH 'CostCenter'.
      REPLACE ALL OCCURRENCES OF:
          'profitcenter' IN l_body WITH 'ProfitCenter'.
      REPLACE ALL OCCURRENCES OF:
          'internalorder' IN l_body WITH 'InternalOrder'.
      REPLACE ALL OCCURRENCES OF:
          'wbselement' IN l_body WITH 'WBSElement'.
      REPLACE ALL OCCURRENCES OF:
          'businessarea' IN l_body WITH 'BusinessArea'.
      REPLACE ALL OCCURRENCES OF:
          'businessprocess' IN l_body WITH 'BusinessProcess'.
      REPLACE ALL OCCURRENCES OF:
          'controllingarea' IN l_body WITH 'ControllingArea'.
      REPLACE ALL OCCURRENCES OF:
          'unplanneddeliverycost' IN l_body WITH 'UnplannedDeliveryCost'.
      REPLACE ALL OCCURRENCES OF:
          'unplanneddeliverycosttaxcode' IN l_body WITH 'UnplannedDeliveryCostTaxCode'.
      REPLACE ALL OCCURRENCES OF:
          'costctractivitytype' IN l_body WITH 'CostCtrActivityType'.
      REPLACE ALL OCCURRENCES OF:
          'costobject' IN l_body WITH 'CostObject'.
      REPLACE ALL OCCURRENCES OF:
          'functionalarea' IN l_body WITH 'FunctionalArea'.
      REPLACE ALL OCCURRENCES OF:
          'isnotcashdiscountliable' IN l_body WITH 'IsNotCashDiscountLiable'.
      REPLACE ALL OCCURRENCES OF:
          'personnelnumber' IN l_body WITH 'PersonnelNumber'.
      REPLACE ALL OCCURRENCES OF:
          'salesorder' IN l_body WITH 'SalesOrder'.
*                'salesorderitem' IN l_body WITH 'SalesOrderItem',
      REPLACE ALL OCCURRENCES OF:
          'projectnetwork' IN l_body WITH 'ProjectNetwork'.
      REPLACE ALL OCCURRENCES OF:
          'networkactivity' IN l_body WITH 'NetworkActivity'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoiceitemamount' IN l_body WITH 'SupplierInvoiceItemAmount'.
      REPLACE ALL OCCURRENCES OF:
          'paymentmethodsupplement' IN l_body WITH 'PaymentMethodSupplement'.
      REPLACE ALL OCCURRENCES OF:
          'companycode2' IN l_body WITH 'CompanyCode'.
*                'supplierinvoicetransactiontype' IN l_body WITH 'SupplierInvoiceTransactionType',
      REPLACE ALL OCCURRENCES OF:
          'invoicingparty' IN l_body WITH 'InvoicingParty'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoiceidbyinvcgparty' IN l_body WITH 'SupplierInvoiceIDByInvcgParty'.
      REPLACE ALL OCCURRENCES OF:
          'documentdate' IN l_body WITH 'DocumentDate'.
      REPLACE ALL OCCURRENCES OF:
          'postingdate' IN l_body WITH 'PostingDate'.
      REPLACE ALL OCCURRENCES OF:
          'accountingdocumenttype' IN l_body WITH 'AccountingDocumentType'.
      REPLACE ALL OCCURRENCES OF:
          'documentcurrency' IN l_body WITH 'DocumentCurrency'.
      REPLACE ALL OCCURRENCES OF:
          'documentheadertext' IN l_body WITH 'DocumentHeaderText'.
      REPLACE ALL OCCURRENCES OF:
          'invoicegrossamount' IN l_body WITH 'InvoiceGrossAmount'.
      REPLACE ALL OCCURRENCES OF:
          'businessplace' IN l_body WITH 'BusinessPlace'.
      REPLACE ALL OCCURRENCES OF:
          'paymentblockingreason' IN l_body WITH 'PaymentBlockingReason'.
      REPLACE ALL OCCURRENCES OF:
          'paymentterms' IN l_body WITH 'PaymentTerms'.
      REPLACE ALL OCCURRENCES OF:
          'duecalculationbasedate' IN l_body WITH 'DueCalculationBaseDate'.
      REPLACE ALL OCCURRENCES OF:
          'manualcashdiscount' IN l_body WITH 'ManualCashDiscount'.
      REPLACE ALL OCCURRENCES OF:
          'paymentmethod' IN l_body WITH 'PaymentMethod'.
      REPLACE ALL OCCURRENCES OF:
*                'paymentmethodsupplement' IN l_body WITH 'PaymentMethodSupplement',
          'taxiscalculatedautomatically' IN l_body WITH 'TaxIsCalculatedAutomatically'.
      REPLACE ALL OCCURRENCES OF:
          'paymentreference' IN l_body WITH 'PaymentReference'.
      REPLACE ALL OCCURRENCES OF:
          'invoicereference' IN l_body WITH 'InvoiceReference'.
*                'invoicereferencefiscalyear' IN l_body WITH 'InvoiceReferenceFiscalYear',
      REPLACE ALL OCCURRENCES OF:
          'cashdiscount1days' IN l_body WITH 'CashDiscount1Days'.
      REPLACE ALL OCCURRENCES OF:
          'cashdiscount1percent' IN l_body WITH 'CashDiscount1Percent'.
      REPLACE ALL OCCURRENCES OF:
          'cashdiscount2days' IN l_body WITH 'CashDiscount2Days'.
      REPLACE ALL OCCURRENCES OF:
          'netpaymentdays' IN l_body WITH 'NetPaymentDays'.
      REPLACE ALL OCCURRENCES OF:
          'fixedcashdiscount' IN l_body WITH 'FixedCashDiscount'.
*                'referencedocumentcategory' IN l_body WITH 'ReferenceDocumentCategory',
      REPLACE ALL OCCURRENCES OF:
          'assignmentreference' IN l_body WITH 'AssignmentReference'.
      REPLACE ALL OCCURRENCES OF:
          'supplierpostinglineitemtext' IN l_body WITH 'SupplierPostingLineItemText'.
      REPLACE ALL OCCURRENCES OF:
          'businesssectioncode' IN l_body WITH 'BusinessSectionCode'.
      REPLACE ALL OCCURRENCES OF:
          'paytslipwthrefsubscriber' IN l_body WITH 'PaytSlipWthRefSubscriber'.
      REPLACE ALL OCCURRENCES OF:
          'paytslipwthrefcheckdigit' IN l_body WITH 'PaytSlipWthRefCheckDigit'.
      REPLACE ALL OCCURRENCES OF:
          'paytslipwthrefreference' IN l_body WITH 'PaytSlipWthRefReference'.
      REPLACE ALL OCCURRENCES OF:
          'businessarea' IN l_body WITH 'BusinessArea'.
      REPLACE ALL OCCURRENCES OF:
          'invoicereceiptdate' IN l_body WITH 'InvoiceReceiptDate'.
      REPLACE ALL OCCURRENCES OF:
          'deliveryofgoodsreportingcntry' IN l_body WITH 'DeliveryOfGoodsReportingCntry'.
      REPLACE ALL OCCURRENCES OF:
          'iseutriangulardeal' IN l_body WITH 'IsEUTriangularDeal'.
      REPLACE ALL OCCURRENCES OF:
          'taxdeterminationdate' IN l_body WITH 'TaxDeterminationDate'.
      REPLACE ALL OCCURRENCES OF:
          'housebank' IN l_body WITH 'HouseBank'.
*                'housebankaccount' IN l_body WITH 'HouseBankAccount',
      REPLACE ALL OCCURRENCES OF:
          'unplnddeliverycosttaxcountry' IN l_body WITH 'UnplndDeliveryCostTaxCountry'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificref1' IN l_body WITH 'JrnlEntryCntrySpecificRef1'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificdate1' IN l_body WITH 'JrnlEntryCntrySpecificDate1'.
      REPLACE ALL OCCURRENCES OF:
          'bpbankaccountinternalid' IN l_body WITH 'BPBankAccountInternalID'.
      REPLACE ALL OCCURRENCES OF:
          'taxreportingdate' IN l_body WITH 'TaxReportingDate'.
      REPLACE ALL OCCURRENCES OF:
          'taxfulfillmentdate' IN l_body WITH 'TaxFulfillmentDate'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificbp1' IN l_body WITH 'JrnlEntryCntrySpecificBP1'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificbp2' IN l_body WITH 'JrnlEntryCntrySpecificBP2'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificdate2' IN l_body WITH 'JrnlEntryCntrySpecificDate2'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificdate3' IN l_body WITH 'JrnlEntryCntrySpecificDate3'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificdate4' IN l_body WITH 'JrnlEntryCntrySpecificDate4'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificdate5' IN l_body WITH 'JrnlEntryCntrySpecificDate5'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificref2' IN l_body WITH 'JrnlEntryCntrySpecificRef2'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificref3' IN l_body WITH 'JrnlEntryCntrySpecificRef3'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificref4' IN l_body WITH 'JrnlEntryCntrySpecificRef4'.
      REPLACE ALL OCCURRENCES OF:
          'jrnlentrycntryspecificref5' IN l_body WITH 'JrnlEntryCntrySpecificRef5'.
      REPLACE ALL OCCURRENCES OF:
          'paymentreason' IN l_body WITH 'PaymentReason'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoicestatus' IN l_body WITH 'SupplierInvoiceStatus'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoiceiscreditmemo' IN l_body WITH 'SupplierInvoiceIsCreditMemo'
          .
      REPLACE ALL OCCURRENCES OF :
      'to_supplierinvoiceitemglacct' IN l_body WITH 'to_SupplierInvoiceItemGLAcct'.
      REPLACE ALL OCCURRENCES OF:
          'supplierinvoiceitem' IN l_body WITH 'SupplierInvoiceItem'.
      REPLACE ALL OCCURRENCES OF:
          'companycode' IN l_body WITH 'CompanyCode'.
      REPLACE ALL OCCURRENCES OF:
          'glaccount' IN l_body WITH 'GLAccount'.
*                'supplierinvoiceitemtext' IN l_body WITH 'SupplierInvoiceItemText',
      REPLACE ALL OCCURRENCES OF:
          'debitcreditcode' IN l_body WITH 'DebitCreditCode'.
*                'supplierinvoiceitemamount' IN l_body WITH 'SupplierInvoiceItemAmount',
      REPLACE ALL OCCURRENCES OF:
          'workitem' IN l_body WITH 'WorkItem'.
      REPLACE ALL OCCURRENCES OF:
          'commitmentitem' IN l_body WITH 'CommitmentItem'.
      REPLACE ALL OCCURRENCES OF:
          'fundscenter' IN l_body WITH 'FundsCenter'.
      REPLACE ALL OCCURRENCES OF:
          'taxbaseamountintranscrcy' IN l_body WITH 'TaxBaseAmountInTransCrcy'.
      REPLACE ALL OCCURRENCES OF:
          'fund' IN l_body WITH 'Fund'.
      REPLACE ALL OCCURRENCES OF:
          'grantid' IN l_body WITH 'GrantID'.
      REPLACE ALL OCCURRENCES OF:
          'quantityunit' IN l_body WITH 'QuantityUnit'.
      REPLACE ALL OCCURRENCES OF:
          'quantity' IN l_body WITH 'Quantity'.
      REPLACE ALL OCCURRENCES OF:
          'servicedocumenttype' IN l_body WITH 'ServiceDocumentType'.
      REPLACE ALL OCCURRENCES OF:
          'servicedocument' IN l_body WITH 'ServiceDocument'.
      REPLACE ALL OCCURRENCES OF:
          'servicedocumentitem' IN l_body WITH 'ServiceDocumentItem'.
      REPLACE ALL OCCURRENCES OF:
          'taxcountry' IN l_body WITH 'TaxCountry'.
      REPLACE ALL OCCURRENCES OF:
          'financialtransactiontype' IN l_body WITH 'FinancialTransactionType'.
      REPLACE ALL OCCURRENCES OF:
          'budgetperiod' IN l_body WITH 'BudgetPeriod'.

      CLEAR: l_url, l_status, l_text.
      FREE: lr_http_destination, lr_web_http_client, lr_request, lr_response.
      IF  sy-sysid = w_clientd.
        l_url = `https://my417265-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
      ELSEIF sy-sysid = w_clientt.
        l_url = `https://my417295-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
      ELSEIF sy-sysid = w_clientp.
*                    l_url = `https://my410597-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SALES_ORDER_SRV/A_SalesOrder`.
        l_url = `https://my422106-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SUPPLIERINVOICE_PROCESS_SRV/A_SupplierInvoice`.
      ENDIF.
      TRY.
          lr_http_destination = cl_http_destination_provider=>create_by_url( i_url = l_url ).
        CATCH cx_http_dest_provider_error INTO DATA(lr_data).
          a = 5.
      ENDTRY.
      TRY.
          lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).
        CATCH cx_web_http_client_error INTO DATA(lr_data2).
          a = 6.
      ENDTRY.
      lr_request = lr_web_http_client->get_http_request( ).
      l_name = 'yy1_prexportiv'.
      l_password = l_pass.
      lr_request->set_authorization_basic( i_username = l_name i_password = l_password ).
      lr_request->set_header_fields( i_fields = lt_header ).
      lr_request->set_text( i_text = l_body ).
      TRY.
          lr_web_http_client->set_csrf_token( ).
          lr_response = lr_web_http_client->execute( i_method = if_web_http_client=>post ).
        CATCH cx_web_http_client_error INTO lr_data2.
          a = 7.
      ENDTRY.
      IF lr_response IS BOUND.
        l_status = lr_response->get_status( ).
        l_text = lr_response->get_text( ).
        TRY.
            lr_web_http_client->close( ).
          CATCH cx_web_http_client_error INTO lr_data2.
            a = 8.
        ENDTRY.
      ENDIF.
      /ui2/cl_json=>deserialize( EXPORTING json = l_text pretty_name = /ui2/cl_json=>pretty_mode-none CHANGING data = lwa_res ).
      "成功產生發票 更新請購單對應項目的已結算與匯入紀錄
      IF l_status-code = 201.
*                    LOOP AT lt_text INTO lwa_text.
        LOOP AT lt_prexport INTO lwa_prexport WHERE id =  lwa_result2-id .
          CLEAR:  l_body, lt_header.
          lt_header =
                VALUE #(
                 ( name = 'Accept' value = 'application/json'  )
                 ( name = 'Content-Type' value = 'application/json'  )
                 ( name = 'If-Match' value = '*'  ) ).
          "  l_url = `https://my405690-api.s4hana.cloud.sap/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002/A_OutbDeliveryItem(DeliveryDocument='80000010',DeliveryDocumentItem='000010')`.
*                        l_url =  `https://my405690-api.s4hana.cloud.sap/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002/A_OutbDeliveryHeader('0080000095')` .

*                        l_vbeln = lwa_text-supplierinvoiceitemtext+0(10).
          l_vbeln = lwa_prexport-purchaserequisition.
*                        l_posnr = lwa_text-supplierinvoiceitemtext+11(5).
          l_posnr = lwa_prexport-purchaserequisitionitem.
          IF  sy-sysid = w_clientd.
*                            l_url = `https://my417265-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEREQ_PROCESS_SRV/A_PurchaseRequisitionItem`.
            l_url = `https://my417265-api.s4hana.cloud.sap/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001/PurchaseReqnItem/`.
          ELSEIF sy-sysid = w_clientt.
*                            l_url = `https://my417295-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PURCHASEREQ_PROCESS_SRV/A_PurchaseRequisitionItem`.
            l_url = `https://my417295-api.s4hana.cloud.sap/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001/PurchaseReqnItem/`.
          ELSEIF sy-sysid = w_clientp.
*                            l_url = `https://my410597-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SALES_ORDER_SRV/A_SalesOrder`.
            l_url = `https://my422106-api.s4hana.cloud.sap/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001/PurchaseReqnItem/`.
          ENDIF.
*                        CONCATENATE l_url '(PurchaseRequisition=''' l_vbeln ''',PurchaseRequisitionItem=''' l_posnr ''')' INTO l_url.
          CONCATENATE l_url l_vbeln '/' l_posnr  INTO l_url.
*                        l_body = `{"d":{"IsClosed":true,"YY1_EXPORT_RECORD_PRI":"X"}}`.
          l_body = `{"IsClosed":true,"YY1_EXPORT_RECORD_PRI":"X"}`.
          TRY.
              lr_http_destination = cl_http_destination_provider=>create_by_url( i_url = l_url ).
            CATCH cx_http_dest_provider_error INTO DATA(lr_data4).
              a = 5.
          ENDTRY.
          TRY.
              lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).
            CATCH cx_web_http_client_error INTO DATA(lr_data5).
              a = 6.
          ENDTRY.
          lr_request = lr_web_http_client->get_http_request( ).
          l_name = 'yy1_prexportiv'.
          l_password = l_pass.
          lr_request->set_authorization_basic( i_username = l_name i_password = l_password ).
          lr_request->set_header_fields( i_fields = lt_header ).
          lr_request->set_text( i_text = l_body ).
          TRY.
              lr_web_http_client->set_csrf_token( ).
              lr_response = lr_web_http_client->execute( i_method = if_web_http_client=>patch ).
            CATCH cx_web_http_client_error INTO lr_data2.
              a = 7.
          ENDTRY.
          IF lr_response IS BOUND.
            l_status = lr_response->get_status( ).
            l_text = lr_response->get_text( ).
            TRY.
                lr_web_http_client->close( ).
              CATCH cx_web_http_client_error INTO lr_data2.
                a = 8.
            ENDTRY.
          ENDIF.
          IF l_status-code = 204 OR l_status-code = 200 OR ( lwa_prexport-purchaserequisition IS INITIAL AND lwa_res-d-supplierinvoice IS NOT INITIAL ) .
*                            lwa_prexport-msg = '已成功產生發票'.
            CLEAR :  lwa_prexport-msg.
            lwa_prexport-msg = lwa_res-d-supplierinvoice.
            MODIFY lt_prexport FROM lwa_prexport TRANSPORTING msg.

          ELSE.
            CLEAR :  lwa_res_err2 , lwa_prexport-msg.
            /ui2/cl_json=>deserialize( "將資料按照Json格式解譯放入ITAB
                EXPORTING
                  json        =  l_text
                  pretty_name = /ui2/cl_json=>pretty_mode-low_case
                CHANGING
                  data        = lwa_res_err2 ).
            lwa_prexport-msg = lwa_res_err2-error-message.

*                            lwa_prexport-msg = '未成功產生發票'.
            MODIFY lt_prexport FROM lwa_prexport TRANSPORTING msg.
          ENDIF.
*                        TRY.
*                                  lr_web_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lr_http_destination ).
*
*                                  lr_request = lr_web_http_client->get_http_request( ).
*                                  lr_request->set_authorization_basic( i_username = 'yy1_prexportiv' i_password = l_pass ).
*                                  lr_request->set_header_fields( i_fields = lt_header ).
*                                  lr_request->set_text( i_text = l_body ).
*                                  lr_web_http_client->set_csrf_token( ).
*                                  lr_response = lr_web_http_client->execute( i_method
*                                     = if_web_http_client=>patch ).
*                                  IF lr_response IS BOUND.
*                                    l_status = lr_response->get_status( ).
*                                    l_text = lr_response->get_text( ).
*                                  ENDIF.
*                                  lr_web_http_client->close( ).
*                        CATCH cx_web_http_client_error INTO DATA(lr_data3).
*                        ENDTRY.
        ENDLOOP.

        CLEAR: lt_bseg, lwa_bseg, lt_je.
        SELECT * FROM i_journalentryitem WITH PRIVILEGED ACCESS
          WHERE ledger = '0L'
            AND referencedocumenttype = 'RMRP'
            AND referencedocument = @lwa_res-d-supplierinvoice
            "AND glaccount LIKE '006%'
          INTO CORRESPONDING FIELDS OF TABLE @lt_bseg.

        READ TABLE lt_bseg INTO lwa_bkpf INDEX 1 ..
        IF sy-subrc = 0.
          CLEAR: lwa_je.
          lwa_je-accountingdocument = lwa_bkpf-accountingdocument.
          lwa_je-fiscalyear         = lwa_bkpf-fiscalyear.
          lwa_je-companycode        = lwa_bkpf-companycode.
          lwa_je-%param-%control-_glitems = if_abap_behv=>mk-on.

          CLEAR l_num.
          LOOP AT lt_result INTO lwa_result WHERE id = lwa_result2-id.
            l_num += 1.

            CLEAR: lwa_bseg , lwa_item.
            READ TABLE lt_bseg INTO lwa_bseg
             WITH KEY referencedocument = lwa_res-d-supplierinvoice
                      referencedocumentitem = l_num.
            CHECK sy-subrc = 0.

            lwa_item-glaccountlineitem = lwa_bseg-ledgergllineitem.
            lwa_item-reference3idbybusinesspartner = lwa_result-customer && lwa_result-customername.
            lwa_item-%control-glaccountlineitem = if_abap_behv=>mk-on.
            lwa_item-%control-reference3idbybusinesspartner = if_abap_behv=>mk-on.
            APPEND lwa_item TO lwa_je-%param-_glitems.
          ENDLOOP..

          APPEND lwa_je TO lt_je.

          MODIFY ENTITIES OF i_journalentrytp
            ENTITY journalentry
            EXECUTE change FROM lt_je
            FAILED DATA(lwa_failed_je)
            REPORTED DATA(lwa_reported_je)
            MAPPED DATA(lwa_mapped_je).
        ENDIF.

      ELSE.
        LOOP AT lt_prexport INTO lwa_prexport WHERE id =  lwa_result2-id.
          CLEAR :  lwa_res_err , lwa_prexport-msg.
          /ui2/cl_json=>deserialize( "將資料按照Json格式解譯放入ITAB
              EXPORTING
                json        =  l_text
                pretty_name = /ui2/cl_json=>pretty_mode-low_case
              CHANGING
                data        = lwa_res_err ).
          lwa_prexport-msg = lwa_res_err-error-message-value.

*                    lwa_prexport-msg = '未成功產生發票'.
          MODIFY lt_prexport FROM lwa_prexport TRANSPORTING msg.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
    MODIFY ENTITIES OF zz1_i_prexportiv_d IN LOCAL MODE
    ENTITY zz1_i_prexportiv_d UPDATE SET FIELDS WITH lt_prexport
    MAPPED DATA(lt_mapp_mod)
    REPORTED DATA(report_mod)
    FAILED DATA(failed_mod).
  ENDMETHOD.

ENDCLASS.
