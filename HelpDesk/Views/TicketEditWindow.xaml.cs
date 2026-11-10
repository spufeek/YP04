using System.Windows;

namespace HelpDesk.Views
{
    /// <summary>
    /// Логика взаимодействия для TicketEditWindow.xaml
    /// </summary>
    public partial class TicketEditWindow : Window
    {
        public TicketEditWindow()
        {
            InitializeComponent();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
