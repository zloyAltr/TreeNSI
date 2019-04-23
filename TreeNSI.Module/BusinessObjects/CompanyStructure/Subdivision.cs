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
    [Table("TreeNSI_Subdivision")]
    [DefaultClassOptions]
    public class Subdivision : IHCategory, IXafEntityObject, IObjectSpaceLink, IRegistrationObject
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdSubdivision { get; protected set; }
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
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("ParentId")]
        public virtual Subdivision Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<Subdivision> Children { get; set; }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as Subdivision; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        public Subdivision()
        {
            Children = new BindingList<Subdivision>();
            PeriodicProperty = new BindingList<SubdivisionProperty>();
            prActualDate = DateTime.Now.Date;
        }

        [InverseProperty("Element")]
        public virtual IList<SubdivisionProperty> PeriodicProperty { get; set; }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }


        [NotMapped]
        public virtual string aFullName
        {
            get
            {
                SubdivisionProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.FullName : "";
            }
        }

        
        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                SubdivisionProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private SubdivisionProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private SubdivisionProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            var _list = PeriodicProperty.ToList<SubdivisionProperty>();
            actualProperty = _list.Where<SubdivisionProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<SubdivisionProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion


        #region View Data
        public virtual vSubdivision viewData { get; set; }
        #endregion


        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsGroup = false;
            IsActive = true;

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
        const int ID_DIRECTORY_TYPE = 3;
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
            return this.IdSubdivision;
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
