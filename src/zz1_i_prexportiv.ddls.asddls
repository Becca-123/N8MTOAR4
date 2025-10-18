@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
define root  view entity  ZZ1_I_PREXPORTIV    
    as select from I_PurchaseRequisitionItemAPI01 as eban    
      left outer join I_User as _user1 on eban.CreatedByUser = _user1.UserID
      left outer join I_AddressPersonName as _AddressPersonName1 on _user1.AddressPersonID = _AddressPersonName1.AddressPersonID   and _AddressPersonName1.AddressRepresentationCode = ''    
      left outer join I_ProductGroup_2 as _ProductGroup on _ProductGroup.ProductGroup = eban.MaterialGroup
{
    key eban.PurchaseRequisition,
    key eban.PurchaseRequisitionItem,
    key eban._PurReqnAcctAssgmt.PurchaseReqnAcctAssgmtNumber,
    key eban._PurReqnAcctAssgmt.CostCenter,  
    eban.Supplier, //期望供應商
    cast( '' as abap.char(16)) as YY1_TW_GUINO_PR_PRI, 
    @Semantics.businessDate.at: true
//    case 
//        when eban.MaterialGroup = 'TAX'
//        then eban.YY1_TW_GUINO_DATE_PRI
//        else eban.DeliveryDate
//    end as YY1_TW_GUINO_DATE_PRI,
    eban.YY1_TW_GUINO_DATE_PRI,
    eban.YY1_TW_GUINO_PR_PRI as guino,
    eban.PurReqnItemCurrency,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    eban.YY1_AMT_PRI as ItemNetAmount,  
    eban._PurReqnAcctAssgmt.GLAccount,
//    eban._PurReqnAcctAssgmt.PurchaseReqnAcctAssgmtNumber,
    eban._PurReqnAcctAssgmt.BaseUnit,
    eban._PurReqnAcctAssgmt.Quantity,
    eban._PurReqnAcctAssgmt.MultipleAcctAssgmtDistrPercent,  
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'  
    cast( 0 as abap.curr(13,2)) as amount,    
    case
        when eban.MaterialGroup = 'TAX'
        then concat(concat(concat(concat(eban.YY1_UNINUM_PRI,'/'),eban.YY1_TW_GUINO_DATE_PRI),'/'),concat(concat(concat(concat(eban.PurchaseRequisition,'/'),eban.PurchaseRequisitionItem),'/'),eban._PurReqnAcctAssgmt.PurchaseReqnAcctAssgmtNumber))
//        else concat(concat(concat(concat(eban.PurchaseRequisition,'/'),eban.PurchaseRequisitionItem),'/'),eban._PurReqnAcctAssgmt.PurchaseReqnAcctAssgmtNumber)
        else eban.PurchaseRequisitionItemText
    end as text1,  
//    cast('' as abap.char(1)  )  as text1, 
    case
        when eban.YY1_MINUS_PRI = 'X'
        then 'H'
        else 'S'
    end as hkont,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    eban.PurchaseRequisitionPrice,
    eban.YY1_TAXNUM_PRI as TaxCode,
    case
        when eban.AccountAssignmentCategory = 'P'
        then eban._PurReqnAcctAssgmt.WBSElementExternalID_2
        else eban.YY1_WBS_PRI
    end as wbselement   ,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    eban.YY1_TAX_BASE_PRI,
    eban.PurchasingGroup,  
    eban.YY1_COUNT_PRI ,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.char(4)) as id,
    cast( '00AS' as abap.char(4)) as bukrs1,
    cast( '1' as abap.char(1)) as trade,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as budat1,
//    cast( '' as abap.char(10)) as budat1,
    cast( 'KR' as abap.char(2)) as doctype1,
    concat( eban.PurchaseRequisition , '費用請款' ) as docheadtext,
//    cast( '' as abap.char(25)) as docheadtext,
    cast( '00AS' as abap.char(4)) as bupla,
    cast( '' as abap.char(1)) as payfrozen,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as date1,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    cast( 0 as abap.curr(13,2)) as amount1,
    cast( '' as abap.char(1)) as paymethod1,
    cast( '' as abap.char(2)) as paymethod2,
    cast( '' as abap.char(30)) as paymethod3,
    cast( '' as abap.char(10)) as xblnr1,
    cast( '' as abap.char(4)) as xblnr2,
    cast( '' as abap.char(4)) as paymethod4,
    cast( '' as abap.char(3)) as payday1,
    cast( '' as abap.char(5)) as paydiscount1,
    cast( '' as abap.char(3)) as payday2,
    cast( '' as abap.char(5)) as paydiscount2,
    cast( '' as abap.char(3)) as paytime,
    cast( '' as abap.char(1)) as paycondition,
    cast( '' as abap.char(1)) as deliverycost,
    cast( '' as abap.char(2)) as taxcode2,
    cast( '' as abap.char(15)) as rent1,
    cast( '' as abap.char(1)) as refdoctype,
    cast( '' as abap.char(18)) as number1,
    cast( '' as abap.char(50)) as text2 ,
    cast( '' as abap.char(4)) as code ,
    cast( '' as abap.char(11)) as isruser,
    cast( '' as abap.char(2)) as porcode,
    cast( '' as abap.char(27)) as xblnr3,
    cast( '' as abap.char(4)) as range,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as budat2,
    cast( '' as abap.char(3)) as country1,
    cast( '' as abap.char(1)) as tritrade,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as budat3,
    cast( '' as abap.char(5)) as keypoint,
    cast( '' as abap.char(5)) as accid,
    cast( '' as abap.char(3)) as country2,
    cast( '' as abap.char(1)) as country3,
    cast( '' as abap.char(10)) as countrydate1,
    cast( '' as abap.char(4)) as cobank,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as budat4,
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    cast( '' as abap.dats(8)) as budat5,
    cast( '' as abap.char(10)) as countrypart1,
    cast( '' as abap.char(10)) as countrypart2,
    cast( '' as abap.char(10)) as countrydate2,
    cast( '' as abap.char(10)) as countrydate3,
    cast( '' as abap.char(10)) as countrydate4,
    cast( '' as abap.char(10)) as countrydate5,
    cast( '' as abap.char(25)) as country4,
    cast( '' as abap.char(25)) as country5,
    cast( '' as abap.char(50)) as country6,
    cast( '' as abap.char(50)) as country7,
    cast( '' as abap.char(34)) as ibanacc,
    cast( '' as abap.char(140)) as country8,
    cast( '' as abap.char(4)) as payreason,
    cast( '' as abap.char(3)) as ivopage,
    cast( '' as abap.char(3)) as country9,
    cast( '' as abap.char(3)) as centralbank,
    cast( '' as abap.char(10)) as adjust,
    cast( '' as abap.char(1)) as ivosource,
    cast( '' as abap.char(2)) as docsource,
    cast( '' as abap.char(16)) as uuid,
    cast( '' as abap.char(2)) as upivosource,
    cast( '00AS' as abap.char(4)) as bukrs2,
    cast( '' as abap.char(15)) as rent2,
    eban._PurReqnAcctAssgmt.ProfitCenter as kostl, 
//    cast( '' as abap.char(10)) as kostl,
    cast( '' as abap.char(12)) as vbeln1,
    cast( '' as abap.char(4)) as busrange,
    cast( '' as abap.char(12)) as busprocess,
    cast( '' as abap.char(4)) as costcontrol,
    cast( '' as abap.char(6)) as worktype,
    cast( '' as abap.char(12)) as costelement,
    eban._PurReqnAcctAssgmt.FunctionalArea as funcrange,     
//    cast( '' as abap.char(16)) as funcrange,
    cast( '' as abap.char(1)) as nondiscount,
    cast( '' as abap.char(8)) as employeenum,
    cast( '' as abap.char(10)) as vbeln2,
    cast( '' as abap.char(6)) as posnr,
    cast( '' as abap.char(12)) as number2,
    cast( '' as abap.char(4)) as vornr,
    cast( '' as abap.char(10)) as workid,
    cast( '' as abap.char(14)) as item,
    cast( '' as abap.char(16)) as foundcenter,
    cast( '' as abap.char(10)) as founder,
    cast( '' as abap.char(20)) as donate,
    cast( '' as abap.char(3)) as unit,
    cast( '' as abap.char(13)) as kwmeng,
    cast( '' as abap.char(4)) as partrange,
    cast( '' as abap.char(4)) as servtype,
    cast( '' as abap.char(10)) as servdocid,
    cast( '' as abap.char(6)) as servitemid,
    cast( '' as abap.char(3)) as country10,
    cast( '' as abap.char(3)) as tradetype,
    cast( '' as abap.char(10)) as budgetperiod,
    cast( '' as abap.char(10)) as founddocnum,
    cast( '' as abap.char(3)) as founddocitem,
    cast( '' as abap.char(1)) as docfinish,
    cast( '' as abap.char(2)) as recover,
    eban.YY1_KUNNR2_PRI as customer,
    eban._YY1_KUNNR2_PRI.CustomerName as customername
}  where eban.PurchaseRequisitionStatus is not initial and eban.YY1_EXPORT_RECORD_PRI is initial and eban.IsDeleted is initial
