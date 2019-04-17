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
    [Table("TreeNSI_Addr_CountryAddressesClassifierLocality")]
    [DefaultClassOptions]
    public class CountryAddressesClassifierLocality
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdClassifier { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32? IdCountry { get; set; }
        [Required]
        [FieldSize(300)]
        [RuleRequiredField(DefaultContexts.Save)]
        public String Name { get; set; }
        [FieldSize(20)]
        public string Acronim { get; set; }
        [FieldSize(100)]
        public string TableName { get; set; }
        [FieldSize(100)]
        public string KeyFieldName { get; set; }

        [ForeignKey("IdCountry")]
        public virtual Country Country { get; set; }

    }
}
