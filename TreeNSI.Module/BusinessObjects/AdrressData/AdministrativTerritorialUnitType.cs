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
    [Table("TreeNSI_Addr_AdministrativTerritorialUnitType")]
    [DefaultClassOptions]
    public class AdministrativTerritorialUnitType : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdATUType { get; protected set; }
        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(20)]
        public string Acronim { get; set; }
        public int? DefaultOrder { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public ATUTypeDefaulPrefix DefaultPrefix { get; set; }

        public AdministrativTerritorialUnitType()
        {
            NationalData = new BindingList<AdministrativTerritorialUnitTypeNationalData>();
        }

        [InverseProperty("AdministrativTerritorialUnitType")]
        public virtual IList<AdministrativTerritorialUnitTypeNationalData> NationalData { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            DefaultPrefix = ATUTypeDefaulPrefix.Префикс;

        }
        #endregion initialization

        #region data from view
        void IXafEntityObject.OnLoaded()
        {
        }
        #endregion data from view


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
