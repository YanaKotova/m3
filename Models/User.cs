using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Module3.Models;

[Table("users")] 
public partial class User
{
    public int Id { get; set; }

    public string Login { get; set; }

    public string Password { get; set; }

    public bool IsFirstLogin { get; set; }

    public bool IsAdmin { get; set; }

    public bool IsBlocked { get; set; }

    public int CounterFailed { get; set; }

    public DateTime? LastLogin { get; set; }
}