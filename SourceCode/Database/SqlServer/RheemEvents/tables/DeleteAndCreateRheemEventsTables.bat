sqlcmd -Q "DROP TABLE RheemEvents..AssetTracking"
sqlcmd -Q "DROP TABLE RheemEvents..Booth"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventAddress"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventAsset"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventCollateral"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventDetail"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventHotel"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventPerson"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventTask"
sqlcmd -Q "DROP TABLE RheemEvents..Asset"
sqlcmd -Q "DROP TABLE RheemEvents..AssetCategory"
sqlcmd -Q "DROP TABLE RheemEvents..Collateral"
sqlcmd -Q "DROP TABLE RheemEvents..CollateralType"
sqlcmd -Q "DROP TABLE RheemEvents..Hotel"
sqlcmd -Q "DROP TABLE RheemEvents..Task"
sqlcmd -Q "DROP TABLE RheemEvents..PanelHistory"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventPanel"
sqlcmd -Q "DROP TABLE RheemEvents..Panel"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventLog"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEventBudget"
sqlcmd -Q "DROP TABLE RheemEvents..RheemEvent"
sqlcmd -i .\RheemEvent_Create.sql
sqlcmd -i .\AssetTracking_Create.sql
sqlcmd -i .\Asset_Create.sql
sqlcmd -i .\AssetCategory_Create.sql
sqlcmd -i .\Booth_Create.sql
sqlcmd -i .\Collateral_Create.sql
sqlcmd -i .\CollateralType_Create.sql
sqlcmd -i .\Hotel_Create.sql
sqlcmd -i .\Task_Create.sql
sqlcmd -i .\RheemEventAddress_Create.sql
sqlcmd -i .\RheemEventAsset_Create.sql
sqlcmd -i .\RheemEventCollateral_Create.sql
sqlcmd -i .\RheemEventDetail_Create.sql
sqlcmd -i .\RheemEventHotel_Create.sql
sqlcmd -i .\RheemEventPerson_Create.sql
sqlcmd -i .\RheemEventTask_Create.sql
sqlcmd -i .\Panel_Create.sql
sqlcmd -i .\RheemEventPanel_Create.sql
sqlcmd -i .\PanelHistory_Create.sql
sqlcmd -i .\RheemEventLog_Create.sql
sqlcmd -i .\RheemEventBudget_Create.sql
pause