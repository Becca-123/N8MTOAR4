@EndUserText.label: '請購單列印 CDSVIEW'
@AccessControl.authorizationCheck: #NOT_REQUIRED
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
define root view entity ZZ1_I_PURCHASEREQ
    as select from I_PurchaseRequisitionItemAPI01 as eban
      left outer join I_User as _user1 on eban.CreatedByUser = _user1.UserID
      left outer join I_AddressPersonName as _AddressPersonName1 on _user1.AddressPersonID = _AddressPersonName1.AddressPersonID   and _AddressPersonName1.AddressRepresentationCode = ''    
      left outer join I_ProductGroup_2 as _ProductGroup on _ProductGroup.ProductGroup = eban.MaterialGroup
{
    key eban.PurchaseRequisition,
    key eban.PurchaseRequisitionItem,
    key eban._PurReqnAcctAssgmt.PurchaseReqnAcctAssgmtNumber,
    key eban._PurReqnAcctAssgmt.CostCenter,
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_User', element: 'bname' } } ]
    eban.CreatedByUser,
    _AddressPersonName1.PersonFullName as name,
    @Semantics.businessDate.at: true
    eban.PurchaseReqnCreationDate,
    eban.PurchaseRequisitionItemText,
    eban.MaterialGroup,
    _ProductGroup._ProductGroupText[Language = $session.system_language].ProductGroupName,
    eban.PurchaseRequisitionStatus,
//    eban._PurReqnAcctAssgmt.CostCenter,
    eban.YY1_CASE_NAME_PRI,
    eban.YY1_CASE_NUMBER_PRI,  
    eban.PurReqnItemCurrency,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    @DefaultAggregation: #NONE
    eban.PurchaseRequisitionPrice,    
    eban.PurchasingGroup,
    eban.YY1_TW_GUINO_PR_PRI,
    case
        when eban.AccountAssignmentCategory = 'P'
        then eban._PurReqnAcctAssgmt.WBSElementExternalID_2
        else eban.YY1_WBS_PRI
        end as wbselement
     
} where eban.CreatedByUser = $session.user and eban.PurchaseRequisitionStatus is not initial and eban.IsDeleted <> 'X'
