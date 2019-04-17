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
    [Table("TreeNSI_Bank")]
    [DefaultClassOptions]
    public class Bank
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdBank { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdCounteragent { get; set; }

        [StringLength(15)]
        [FieldSize(15)]
        public String LocalRegistrationCode { get; set; }

        [StringLength(15)]
        [FieldSize(15)]
        public String SSWIFT_BIC { get; set; }

        [ForeignKey("IdCounteragent")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Counteragent Counteragent { get; set; }


    }
}
