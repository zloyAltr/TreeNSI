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

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_CounteragentAddress")]
    [DefaultClassOptions]
    public class CounteragentAddress : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCountragentAddress { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdCounteragent { get; set; }
        [Required]
        [Browsable(false)]
        public Int32? IdAddress { get; set; }
        public Int32? IdAddressType { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCounteragent")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Counteragent Counteragent { get; set; }

        [ForeignKey("IdAddress")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual BusinessObjects.Address Address { get; set; }

        [ForeignKey("IdAddressType")]
        public virtual AddressType AddressType { get; set; }

        public virtual CounteragentAddressExtraInfo ExtraInfo { get; set; }
        //public virtual string ExtraInfo { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                return String.Format("{0} {1}{2}",
                    (this.Counteragent == null) ? "" : Counteragent.Name.Trim(),
                    (this.AddressType == null) ? "" : String.Format("({0}) ",this.AddressType.Name.Trim()),
                    (this.Address == null) ? "" : this.Address.aName.Trim()
                    );
            }
        }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            BeginDate = DateTime.Now.Date;
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
    }
}
