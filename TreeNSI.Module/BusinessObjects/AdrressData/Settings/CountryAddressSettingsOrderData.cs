using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using DevExpress.ExpressApp;


namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_CountryAddressSettingsOrderData")]
    [DefaultClassOptions]
    public class CountryAddressSettingsOrderData : IXafEntityObject, IObjectSpaceLink
    {
        [Column(Order = 0), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddressSettings { get; set; }

        [Column(Order = 1), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdATUType { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public ATUTypeDefaulPrefix Prefix { get; set; }
        public int? OrderNumber { get; set; }

        [ForeignKey("IdAddressSettings")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual CountryAddressSettings CountryAddressSettings { get; set; }
        [ForeignKey("IdATUType")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual AdministrativTerritorialUnitType AdministrativTerritorialUnitType { get; set; }


        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            Prefix = ATUTypeDefaulPrefix.Префикс;

        }
        #endregion initialization

        
        void IXafEntityObject.OnLoaded()
        {
        }
        


        void IXafEntityObject.OnSaving()
        {

        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject
    }
}
