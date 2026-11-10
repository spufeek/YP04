using System.Windows;

namespace HelpDesk.Views
{
    /// <summary>
    /// Логика взаимодействия для TicketCreateWindow.xaml
    /// </summary>
    public partial class TicketCreateWindow : Window
    {
        public TicketCreateWindow()
        {
            InitializeComponent();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
