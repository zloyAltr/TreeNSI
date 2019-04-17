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
    [Table("TreeNSI_CountryUnionMember")]
    [DefaultClassOptions]
    public class CountryUnionMember
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCountryUnionMember { get; protected set; }
        [Required]
        public Int32? IdCountryUnion { get; set; }
        [Required]
        public Int32? IdCountry { get; set; }
        public DateTime? BeginDate { get; set; }
        public DateTime? EndDate { get; set; }

        [ForeignKey("IdCountryUnion")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual CountryUnion CountryUnion { get; set; }
        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }
    }
}
