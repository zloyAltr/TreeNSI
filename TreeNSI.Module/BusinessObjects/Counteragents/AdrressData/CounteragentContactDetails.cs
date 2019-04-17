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
    [Table("TreeNSI_CounteragentContactDetails")]
    [DefaultClassOptions]
    public class CounteragentContactDetails : IXafEntityObject, IObjectSpaceLink, INewItem
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdContactDetails { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdCounteragent { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public string PhoneNumber { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public String Email { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public String Web { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public string ContactPerson { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCounteragent")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Counteragent Counteragent { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
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
        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject

        public void NewItem()
        {
            for(int i = LastModel.lastActiveObject.Count; i >= 0; i--)
            {
                Counteragent _ManeElement = null;
                try
                {

                    _ManeElement = (Counteragent)LastModel.lastActiveObject[i];
                        
                }
                catch
                {
                    continue;
                }
                if (_ManeElement != null)
                {
                    this.Counteragent = objectSpace.FindObject<Counteragent>(CriteriaOperator.Parse(String.Format("IdCounteragent={0}",_ManeElement.IdCounteragent)));
                    break;
                }
            }
        }
    }
}
