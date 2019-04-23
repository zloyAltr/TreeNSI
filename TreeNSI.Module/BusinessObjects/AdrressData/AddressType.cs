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
    [Table("TreeNSI_Addr_AddressType")]
    [DefaultClassOptions]
    public class AddressType
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddressType { get; protected set; }
        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
    }
}
