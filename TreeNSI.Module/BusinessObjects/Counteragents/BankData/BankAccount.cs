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
    [Table("TreeNSI_BankAccount")]
    [DefaultClassOptions]
    public class BankAccount : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdBankAccount { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32 IdBank { get; set; }

        [Required]
        [Browsable(false)]
        public Int32 IdCounteragent { get; set; }

        [FieldSize(34)]
        [StringLength(34)]
        public String Number { get; set; }

        [FieldSize(34)]
        [StringLength(34)]
        public String NumberIBAN { get; set; }

        [Required]
        [Browsable(false)]
        public Int32? IdCurrency { get; set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCurrency")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Currency Currency { get; set; }

        [ForeignKey("IdBank")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Bank Bank { get; set; }

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
    }
}
