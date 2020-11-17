#ifndef BIPROGRESSWIDGET_H
#define BIPROGRESSWIDGET_H

#include <QtWidgets>

class biProgressWidget : public QWidget
{
    Q_OBJECT

public:
    biProgressWidget(QWidget* parent = nullptr);

protected slots:
    void toggleDetails();

protected:
    QPushButton* m_detailsToogle;
    QTextEdit* m_proressEdit;
};

#endif // BIPROGRESSWIDGET_H
