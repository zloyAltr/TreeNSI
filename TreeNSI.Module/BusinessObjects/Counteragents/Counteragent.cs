using System;
using System.Linq;
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
    [Table("TreeNSI_Counteragent")]
    [DefaultClassOptions]
    public class Counteragent : IHCategory, IXafEntityObject, IObjectSpaceLink, IRegistrationObject
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCounteragent { get; protected set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32? IdCatalog { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }

        [FieldSize(100)]
        [StringLength(100)]
        public string Name { get; set; }
        [Required]
        public Int32? IdCountry { get; set; }

        [RuleRequiredField(DefaultContexts.Save)]
        [ForeignKey("IdCountry")]
        public virtual Country Country { get; set; }

        [ForeignKey("ParentId")]
        public virtual Counteragent Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<Counteragent> Children { get; set; }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as Counteragent; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        public Counteragent()
        {
            Children = new BindingList<Counteragent>();
            PeriodicProperty = new BindingList<CounteragentProperty>();
            prActualDate = DateTime.Now.Date;
            RegistrationNumber = new BindingList<CounteragentRegistrationNumber>();
            NationalData = new BindingList<CounteragentNationalData>();
            AddressData = new BindingList<CounteragentAddress>();
            ContactDetails = new BindingList<CounteragentContactDetails>();
            BankAccount = new BindingList<BankAccount>();
            Bank = new BindingList<Bank>();
        }

        [InverseProperty("Counteragent")]
        public virtual IList<CounteragentRegistrationNumber> RegistrationNumber { get; set; }

        [InverseProperty("Element")]
        public virtual IList<CounteragentProperty> PeriodicProperty { get; set; }
        [InverseProperty("Counteragent")]
        public virtual IList<CounteragentNationalData> NationalData { get; set; }
        [InverseProperty("Counteragent")]
        public virtual IList<CounteragentAddress> AddressData { get; set; }
        [InverseProperty("Counteragent")]
        public virtual IList<CounteragentContactDetails> ContactDetails { get; set; }

        [InverseProperty("Counteragent")]
        public virtual IList<BankAccount> BankAccount { get; set; }
        [InverseProperty("Counteragent")]
        public virtual IList<Bank> Bank { get; set; }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }
        

        [NotMapped]
        public virtual string aFullName
        {
            get
            {
                CounteragentProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.FullName : "";
            }
        }

        [NotMapped]
        public virtual bool? aIsActive
        {
            get
            {
                CounteragentProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.IsActive : null;
            }
        }

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                CounteragentProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private CounteragentProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private CounteragentProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            var _list = PeriodicProperty.ToList<CounteragentProperty>();
            actualProperty = _list.Where<CounteragentProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<CounteragentProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion

        #region View Data
        public virtual vCounteragent viewData { get; protected set; }
        #endregion
        

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsGroup = false;

        }
        #endregion initialization

        #region data from view
        void IXafEntityObject.OnLoaded()
        {
        }
        #endregion data from view


        void IXafEntityObject.OnSaving()
        {
            setIdCatalog();
        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject

        #region IRegistrationObject
        const int ID_DIRECTORY_TYPE = 2;
        public int GetIdCatalog()
        {
            return this.IdCatalog.Value;
        }

        public int GetIdTypeDirectory()
        {
            return ID_DIRECTORY_TYPE;
        }

        public int GetId()
        {
            return this.IdCounteragent;
        }

        private void setIdCatalog()
        {
            if (objectSpace != null && !objectSpace.IsObjectToDelete(this) && !this.IdCatalog.HasValue)
            {
                this.IdCatalog = DbMethods.Registration(ID_DIRECTORY_TYPE).Value;
            }
        }
        #endregion IRegistrationObject
    }
}
