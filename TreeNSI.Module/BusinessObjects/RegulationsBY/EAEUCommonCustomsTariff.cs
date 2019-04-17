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
    //[NavigationItem("Нормативные данные")]
    [Table("TreeNSI_EAEUCommonCustomsTariff")]
    [DefaultClassOptions]
    public class EAEUCommonCustomsTariff : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        public EAEUCommonCustomsTariff()
        {
            Children = new BindingList<EAEUCommonCustomsTariff>();
        }

        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCommonCustomsTariff { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [FieldSize(15)]
        public String Code { get; set; }
        [Required]
        [FieldSize(1000)]
        [StringLength(1000)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string AdditionalMeasurementUnit { get; set; }
        [FieldSize(70)]
        [StringLength(70)]
        public string DutyRate { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        #region TreeData

        [ForeignKey("ParentId")]
        public virtual EAEUCommonCustomsTariff Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<EAEUCommonCustomsTariff> Children { get; set; }

        IBindingList ITreeNode.Children
        {
            get { return this.Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return this.Parent as IHCategory; }
            set { this.Parent = value as EAEUCommonCustomsTariff; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return this.Parent as ITreeNode; }
        }
        #endregion

        #region View from SQL
        //[ForeignKey("IdCommonCustomsTariff")]
        ////[NotMapped]
        //public virtual vEAEUCommonCustomsTariff vList { get; set; }
        #endregion

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            IsGroup = false;
        }
        #endregion initialization

        void IXafEntityObject.OnLoaded()
        {
            //слишком долго
            //IObjectSpace _objectSpace = objectSpace.CreateNestedObjectSpace();
            //vList = _objectSpace.FindObject<vEAEUCommonCustomsTariff>(CriteriaOperator.Parse(String.Format("IdCommonCustomsTariff={0}", this.IdCommonCustomsTariff)));

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
