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
    [Table("TreeNSI_MeasurementUnit")]
    [DefaultClassOptions]
    public class MeasurementUnit : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        public MeasurementUnit()
        {
            Children = new BindingList<MeasurementUnit>();
        }

        [Key]//, DatabaseGenerated(DatabaseGeneratedOption.Identity)
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdMeasurementUnit { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(200)]
        [StringLength(200)]
        public String Description { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string InternationalCode { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string DomesticCode { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        [Required]
        public string DomesticIdentificationCode { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string InternationalIdentificationCode { get; set; }
        [FieldSize(50)]
        [StringLength(50)]
        public string DomesticSymbolCode { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string InternationalSymbolCode { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }


        [ForeignKey("ParentId")]
        public virtual MeasurementUnit Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<MeasurementUnit> Children { get; set; }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as MeasurementUnit; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        #region View from SQL
        //[ForeignKey("IdMeasurementUnit")]
        //[NotMapped]
        //public virtual vMeasurementUnit vList { get; set; }

        [NotMapped]
        public virtual String vDomesticIdentificationCodeForPrint
        {
            get
            {
                return (String.IsNullOrEmpty(this.DomesticIdentificationCode)) ? "" :
                    this.DomesticIdentificationCode.Replace("^3", ((char)0179).ToString()).Replace("^2", ((char)0178).ToString());
            }
        }

        [NotMapped]
        public virtual String vInternationalIdentificationCodeForPrint
        {
            get
            {
                return (String.IsNullOrEmpty(this.InternationalIdentificationCode)) ? "" :
                    this.InternationalIdentificationCode.Replace("^3", ((char)0179).ToString()).Replace("^2", ((char)0178).ToString());
            }
        }

        [NotMapped]
        public virtual String vCode
        {
            get
            {
                return (!String.IsNullOrEmpty(this.InternationalCode)) ? this.InternationalCode : this.DomesticCode ;
            }
        }
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
            //IObjectSpace _objectSpace = objectSpace.CreateNestedObjectSpace();
            //vList = _objectSpace.FindObject<vMeasurementUnit>(CriteriaOperator.Parse(String.Format("IdMeasurementUnit={0}", this.IdMeasurementUnit)));
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
