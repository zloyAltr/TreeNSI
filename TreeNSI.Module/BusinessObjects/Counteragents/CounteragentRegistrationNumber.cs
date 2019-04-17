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
    [Table("TreeNSI_CounteragentRegistrationNumber")]
    [DefaultClassOptions]
    public class CounteragentRegistrationNumber
    {
        [Column(Order = 0), Key]//, ForeignKey("Counteragent")
        [Required]
        public Int32 IdCounteragent { get; set; }
        [Column(Order = 1), Key/*, ForeignKey("CounteragentRegistrationNumbersType")*/]
        [Required]
        public Int32 IdRegNumberType { get; set; }
        //[Column(Order = 3), Key]
        [Required]
        [FieldSize(20)]
        [StringLength(20)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Number { get; set; }

        [RuleRequiredField(DefaultContexts.Save)]
        [ForeignKey("IdCounteragent")]
        public virtual Counteragent Counteragent { get; set; }
        [RuleRequiredField(DefaultContexts.Save)]
        [ForeignKey("IdRegNumberType")]
        public virtual CounteragentRegistrationNumbersType CounteragentRegistrationNumbersType { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                return String.Format("{0} {1}",
                    (CounteragentRegistrationNumbersType != null && !String.IsNullOrWhiteSpace(CounteragentRegistrationNumbersType.ShortName)) ?
                    CounteragentRegistrationNumbersType.ShortName.Trim() : "",
                    (String.IsNullOrWhiteSpace(Number)) ? "" : Number.Trim()
                    );
            }
        }
    }
}
