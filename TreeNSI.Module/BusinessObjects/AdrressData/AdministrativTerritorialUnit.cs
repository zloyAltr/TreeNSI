using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;
using DevExpress.Data.Filtering;



namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_AdministrativTerritorialUnit")]
    [DefaultClassOptions]
    public class AdministrativTerritorialUnit : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdATU { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }

        [Required]
        public Int32? IdATUType { get; set; }
        [Required]
        public Int32? IdCountry { get; set; }

        [ForeignKey("IdATUType")]
        public virtual AdministrativTerritorialUnitType AdministrativTerritorialUnitType { get; set; }
        [ForeignKey("IdCountry")]
        public virtual Country Country { get; set; }

        [InverseProperty("AdministrativTerritorialUnit")]
        public virtual IList<AdministrativTerritorialUnitNationalData> NationalData { get; set; }

        [ForeignKey("ParentId")]
        public virtual AdministrativTerritorialUnit Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<AdministrativTerritorialUnit> Children { get; set; }

        public AdministrativTerritorialUnit()
        {
            Children = new BindingList<AdministrativTerritorialUnit>();
            NationalData = new BindingList<AdministrativTerritorialUnitNationalData>();
        }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as AdministrativTerritorialUnit; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsGroup = false;
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
